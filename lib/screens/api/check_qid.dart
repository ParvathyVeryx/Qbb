import 'dart:convert';
import 'package:QBB/screens/pages/erorr_popup.dart';
import 'package:QBB/screens/pages/loader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Country {
  final int id;
  final String code;
  final String name;

  Country(this.id, this.code, this.name);
}

// Future<void> _retrieveToken() async {
//   try {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var token = prefs.getString('token').toString();
//     print('Tokrn in other screen $token');
//     // Rest of the code...
//   } catch (e) {
//     print('Error retrieving token: $e');
//   }
// }

Future<bool> checkQIDExist(
  String qid,
  BuildContext context,
  TextEditingController nationalityController,
  void Function(int) updateNationalityId, // Add the parameter
  // String token,
) async {
  try {
    // Replace 'your_token' with the actual token you have
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6Im1vYmFkbWluQGdtYWlsLmNvbSIsIm5iZiI6MTcwMzE3ODA1MywiZXhwIjoxNzAzNzgyODUzLCJpYXQiOjE3MDMxNzgwNTMsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTAxOTEiLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjUwMTkxIn0.WYN0dROXwe3ys9yA2Ngd62p7Fr2h6JV4nSyHPcnF4tk";

    // Replace 'your_base_url' with the actual base URL of your API
    String baseUrl =
        "https://participantportal-test.qatarbiobank.org.qa/QbbAPIS/api";

    // Replace 'your_language' with the actual language you want to use
    String language = "en";

    // Construct the API URL
    String apiUrl = '$baseUrl/CheckQIDExistAPI?QID=$qid&language=$language';

    // Set up headers
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LoaderWidget();
      },
    );
    // Make the GET request
    final response = await http.get(Uri.parse(apiUrl), headers: headers);
    Navigator.pop(context);

    if (response.statusCode == 200) {
      // QID exists, proceed to get the country
      String countryCode = qid.substring(3, 6);

      // Construct the GetCountry API URL
      String countryApiUrl =
          '$baseUrl/CountryAPI?id=$countryCode&language=$language';

      // Make the GET request for GetCountry API
      final countryResponse =
          await http.get(Uri.parse(countryApiUrl), headers: headers);

      if (countryResponse.statusCode == 200) {
        // Successful request for GetCountry API
        dynamic countryResponseBody = jsonDecode(countryResponse.body);

        if (countryResponseBody is List) {
          // Handle the case where the response is a list
          List<Country> countryList = countryResponseBody
              .map((countryData) => Country(
                  countryData['Id'], // Include the country ID
                  countryData['PhoneCode'].toString(),
                  countryData['Name']))
              .toList();

          String enteredCountryCode = qid.substring(3, 6);

          Country enteredCountryInfo = getCountryInfoByCode(
            countryList,
            enteredCountryCode,
          );

          // Set the value of the nationalityController
          nationalityController.text = enteredCountryInfo
              .name; // Update the nationalityId using the provided callback
          updateNationalityId(enteredCountryInfo.id);

          print('Entered Country Code: $enteredCountryCode');
          print('Country Name: ${enteredCountryInfo.name}');
          print('Country ID: ${enteredCountryInfo.id}'); // Print the country ID
          return true;
        } else {
          print('Unexpected response format: $countryResponseBody');
          return false;
        }
      } else {
        String errorMessage = response.body;

        // Handle error response for GetCountry API
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorPopup(
              errorMessage: 'Error fetching country: $errorMessage',
            );
          },
        );
        return false;
      }
    } else {
      String errorMessage = response.body;
      // Handle error response for CheckQIDExistAPI
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorPopup(
            errorMessage: 'Error: $errorMessage',
          );
        },
      );
      return false;
    }
  } catch (e) {
    // Handle any exceptions
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ErrorPopup(
          errorMessage: 'Error: $e',
        );
      },
    );
    print('Error while making API request: $e');
    return false;
  }
}

Country getCountryInfoByCode(List<Country> countryList, String countryCode) {
  Country? matchingCountry = countryList.firstWhere(
    (country) => country.code == countryCode,
    orElse: () => Country(0, "", "Unknown Country"), // Default ID to 0
  );

  return matchingCountry;
}

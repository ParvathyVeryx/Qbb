import 'package:QBB/constants.dart';
// import 'package:QBB/l10n/applocalization_ar.dart';
// import 'package:QBB/localization/localization.dart';
import 'package:QBB/nirmal/login_screen.dart';
import 'package:QBB/screens/authentication/forgotPwd.dart';
import 'package:QBB/screens/authentication/loginorReg.dart';
import 'package:QBB/screens/pages/terms_and_conditions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  WelcomeState createState() => WelcomeState();
}

class WelcomeState extends State<Welcome> {
  final List locale = [
    {'name': 'ENGLISH', 'locale': const Locale('en', 'US')},
    {'name': 'عربي', 'locale': const Locale('ar')},
  ];

  // final List<Map<String, dynamic>> locale = [
  //   {'name': 'ENGLISH', 'locale': Locale('en', 'US')},
  //   {'name': 'عربي', 'locale': Locale('ar')},
  // ];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  String password = ''; // Store the entered password
  String confirmPassword = ''; // Store the entered confirm password
  bool isButtonEnabled = false;
  String otp = '';
  String QID = '';
  bool isButtonClicked = true;
  bool isButtonClickedArabic = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: Text(
                  'tutorialSkipButton'.tr,
                  // appLocalizations?.hello ?? 'default',

                  style: const TextStyle(
                    color: appbar,
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 16.0),
            //   child: LanguageToggleSwitch(onLanguageChanged: onLanguageChanged),
            // ),
          ],
        ),
        backgroundColor: textcolor,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/images/bg.png'),
              alignment: Alignment
                  .bottomCenter, // Align the image to the bottom center // Replace with your image path
              fit: BoxFit
                  .contain, // Adjust to your needs (e.g., BoxFit.fill, BoxFit.fitHeight)
            ),
            // color: Colors.blue, // Container background color

            borderRadius: BorderRadius.circular(0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(45.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // ElevatedButton(
                //     onPressed: () {
                //       buildLanguageDialog(context);
                //     },
                //     child: Text('changelang'.tr)),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     ElevatedButton(
                //       onPressed: () async {
                //         SharedPreferences pref =
                //             await SharedPreferences.getInstance();
                //         pref.setString("langEn", "true");
                //         var lan = pref.getString("langEn").toString();
                //         print("jjjjjjjjjjjjjjj" + lan);
                //         updateLanguage(locale[0]['locale']);
                //       },
                //       child: const Text('English'),
                //     ),
                //     ElevatedButton(
                //       onPressed: () async {
                //         SharedPreferences pref =
                //             await SharedPreferences.getInstance();
                //         pref.setString("langEn", "false");
                //         var lan = pref.getString("langAR").toString();
                //         print("jjjjjjjjjjjjjjj" + lan);
                //         updateLanguage(locale[1]['locale']);
                //       },
                //       child: const Text('عربي'),
                //     ),
                //   ],
                // ),

                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: isButtonClicked
                            ? ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(appbar),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20.0),
                                    ),
                                  ),
                                ),
                              )
                            : ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                    side: BorderSide(color: appbar),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(0.0),
                                    ),
                                  ),
                                ),
                              ),
                        onPressed: () async {
                          setState(() {
                            // Toggle the state to change the button style
                            isButtonClicked = true;
                            isButtonClickedArabic = false;
                          });
                          // print('token before calling api $token');
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          pref.setString("langEn", "English");
                          var lan = pref.getString("langEn").toString();
                          print("jjjjjjjjjjjjjjj" + lan);
                          updateLanguage(locale[0]['locale']);
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(6.0, 3.0, 6.0, 3.0),
                          child: isButtonClicked
                              ? Text(
                                  'English',
                                  style: TextStyle(
                                    color: textcolor,
                                  ),
                                )
                              : Text(
                                  'English',
                                  style: TextStyle(
                                    color: appbar,
                                  ),
                                ),
                        ),
                      ),
                      ElevatedButton(
                        style: isButtonClickedArabic
                            ? ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(appbar),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20.0),
                                    ),
                                  ),
                                ),
                              )
                            : ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                    // borderRadius: BorderRadius.only(
                                    //   bottomLeft: Radius.circular(20.0),
                                    // ),
                                    side: BorderSide(color: appbar),
                                  ),
                                ),
                              ),
                        onPressed: () async {
                          setState(() {
                            // Toggle the state to change the button style
                            isButtonClicked = false;
                            isButtonClickedArabic = true;
                          });
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          pref.setString("langAR", "Arabic");
                          var lan = pref.getString("langAR").toString();
                          print("jjjjjjjjjjjjjjj" + lan);
                          updateLanguage(locale[1]['locale']);
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(6.0, 3.0, 6.0, 3.0),
                          child: isButtonClickedArabic
                              ? Text(
                                  'عربي',
                                  style: TextStyle(
                                    color: textcolor,
                                  ),
                                )
                              : Text(
                                  'عربي',
                                  style: TextStyle(
                                    color: appbar,
                                  ),
                                ),
                        ),
                      ),

                      // ElevatedButton(
                      //   onPressed: () async {
                      //     SharedPreferences pref =
                      //         await SharedPreferences
                      //             .getInstance();
                      //     pref.setString("langEn", "English");
                      //     var lan =
                      //         pref.getString("langEn").toString();
                      //     print("jjjjjjjjjjjjjjj" + lan);
                      //     updateLanguageLogin(
                      //         locale[0]['locale']);
                      //   },
                      //   child: const Text('English'),
                      // ),
                      // ElevatedButton(
                      //   onPressed: () async {
                      //     SharedPreferences pref =
                      //         await SharedPreferences
                      //             .getInstance();
                      //     pref.setString("langAR", "Arabic");
                      //     var lan =
                      //         pref.getString("langAR").toString();
                      //     print("jjjjjjjjjjjjjjj" + lan);
                      //     updateLanguageLogin(
                      //         locale[1]['locale']);
                      //   },
                      //   child: const Text('عربي'),
                      // ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),
                Image.asset(
                  "assets/images/logo-welcome-screen.png",
                  width: 80.0,
                  height: 80.0,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  'welcomeToQbb'.tr,
                  style: const TextStyle(
                      color: appbar, fontFamily: 'Impact', fontSize: 28.0),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  'tutorialSlide1Description'.tr,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 107, 107, 107), fontSize: 12),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.white), // Set background color

                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(
                                    20.0), // Rounded border at bottom-left
                              ),
                              side: BorderSide(
                                color:
                                    primaryColor, // Specify the border color here
                                width: 1.0, // Specify the border width here
                              ),
                            ),
                          )),
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(15.0, 18.0, 15.0, 18.0),
                        child: Text(
                          'login'.tr,
                          style: const TextStyle(
                            color: primaryColor,
                          ),
                        ),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgotPassword()),
                        );
                      },
                      child: Text(
                        'forgotPassword'.tr,
                        style:
                            const TextStyle(color: primaryColor, fontSize: 12),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              // builder: (context) => EditProfilePage())
                              builder: (context) => const loginOrReg()),
                        );
                      },
                      child: Text(
                        'create/activateAcc'.tr,
                        style:
                            const TextStyle(color: primaryColor, fontSize: 12),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  'byRegisteringYouAgreeToOur'.tr,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 107, 107, 107)),
                ),
                TextButton(
                  onPressed: () {
                    // const RegistrationMode();  showDialog(
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return TermsAndConditionsDialog();
                      },
                    );
                  },
                  child: Text(
                    'termsConditions'.tr,
                    style: const TextStyle(
                        color: primaryColor,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

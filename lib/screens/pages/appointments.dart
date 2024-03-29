import 'package:QBB/nirmal_api.dart/appointments._api.dart';
import 'package:QBB/screens/pages/all_appointments.dart';
import 'package:QBB/screens/pages/book_appintment_nk.dart';
import 'package:QBB/screens/pages/completed.dart';
import 'package:QBB/screens/pages/profile.dart';
import 'package:QBB/screens/pages/results.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../sidebar.dart';
import 'homescreen_nk.dart';

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  AppointmentsState createState() => AppointmentsState();
}

class AppointmentsState extends State<Appointments> {
  List<Map<String, dynamic>> allAppointments = [];
  List<Map<String, dynamic>> completedAppointments = [];
int currentIndex = 1;
  @override
  void initState() {
    super.initState();
    fetchData();
  } // Ensure you have the correct access token, qid, page, and language before calling this function.

  Future<void> fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var lang = pref.getString("langEn");
    var setLang;
    if (lang == "true") {
      setLang = "en";
    } else {
      setLang = "ar";
    }
    try {
      var appointments = await viewAppointments('28900498437', 1, '$setLang');
      print(appointments);
      setState(() {
        // Set all appointments
        allAppointments = appointments;
        // Filter completed appointments
        completedAppointments = appointments
            .where((appointment) =>
                appointment['AppoinmentStatus'] is int &&
                appointment['AppoinmentStatus'] == 4)
            .toList();
        print('completed Appointments: $completedAppointments');
      });
    } catch (error) {
      // Handle errors, e.g., show an error message.
      print('Error fetching appointments: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Specify the number of tabs
      child: PopScope(
        canPop: true,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Image.asset(
                    "assets/images/icon.png",
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.cover,
                  ),
                ),
                // SizedBox(
                //   width: 50.0,
                // ),

                Text(
                  'appointments'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    // fontWeight: FontWeight.w900 ,
                    fontFamily: 'Impact',
                  ),
                ),
                // SizedBox(
                //   width: 50.0,
                // ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none_outlined),
                  iconSize: 30.0,
                  color: textcolor,
                )
              ],
            ),
            backgroundColor: appbar,
            iconTheme: const IconThemeData(color: textcolor),

            // actions: [
            //   IconButton(
            //     onPressed: () {},
            //     icon: Icon(Icons.notifications_none_outlined),
            //     iconSize: 30.0,
            //   ),
            // ],
            bottom: TabBar(
                tabs: [
                  Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: Tab(text: 'upcoming'.tr),
                  ),
                  Tab(text: 'completed'.tr),
                  Padding(
                    padding: EdgeInsets.only(right: 30.0),
                    child: Tab(text: 'all'.tr),
                  ),
                ],
                indicatorColor: Colors.white, // Set the color of the indicator
                labelColor:
                    Colors.white, // Set the color of the active tab text
                unselectedLabelColor: Color.fromARGB(255, 223, 221, 255)),
          ),
          drawer: const SideMenu(),
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: textcolor,
              unselectedItemColor: textcolor,
              backgroundColor: primaryColor,
              currentIndex: currentIndex,
              unselectedFontSize: 7,
              selectedFontSize: 7,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
                if (index == 0) {
                  // Handle tap for the "HOME" item
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                }
                if (index == 2) {
                  // Handle tap for the "HOME" item
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BookAppointments()),
                  );
                }
                if (index == 3) {
                  // Handle tap for the "HOME" item
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Results()),
                  );
                }
                if (index == 4) {
                  // Handle tap for the "HOME" item
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
                  );
                }


              },
              items: [
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Image.asset(
                        "assets/images/home.png",
                        width: 20.0,
                        height: 20.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    label: 'HOME',
                  ),
                  BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Image.asset(
                          "assets/images/event.png",
                          width: 20.0,
                          height: 20.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      label: 'APPOINTMENT'),
                  BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Image.asset(
                          "assets/images/event.png",
                          width: 20.0,
                          height: 20.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      label: 'BOOK AN APPOINTMENT'),
                  BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Image.asset(
                          "assets/images/experiment-results.png",
                          width: 20.0,
                          height: 20.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      label: 'RESULTS/STATUS'),
                  BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Image.asset(
                          "assets/images/user.png",
                          width: 20.0,
                          height: 20.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      label: 'MY PROFILE'),
                ]),
          body: TabBarView(
            children: [
              // Content of Tab 1
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: Center(
                      child: Text(
                    "thereAreNoAppointments".tr,
                    style: TextStyle(fontSize: 18),
                  ))),

              // Content of Tab 2
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                // child: Center(
                //     child: Text(
                //   "There are no appointments !",
                //   style: TextStyle(fontSize: 18),
                // ))
                child: Completed(
                  completedAppointments: completedAppointments,
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: Center(
                    child: AllAppointments(allAppointments: allAppointments),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

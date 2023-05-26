import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_admin_dashboard/responsive.dart';
import 'package:smart_admin_dashboard/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

import 'components/side_menu.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var token;
  var firstName;
  var lastName;
  getTokenNames() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      token = _prefs.get('token');
      firstName = _prefs.getString('firstName');
      lastName=_prefs.getString('lastName');
    });

    debugPrint('token is>>>>$token');
    debugPrint('fisrtName is>>>>$firstName');

  }
  @override
  void initState() {
    getTokenNames();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: DashboardScreen(
                lastName: lastName, firstName: firstName
              ),
            ),
          ],
        ),
      ),
    );
  }
  }


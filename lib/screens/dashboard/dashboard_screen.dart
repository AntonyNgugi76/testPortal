import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:smart_admin_dashboard/responsive.dart';

import 'package:smart_admin_dashboard/screens/dashboard/components/mini_information_card.dart';

import 'package:smart_admin_dashboard/screens/dashboard/components/recent_forums.dart';
import 'package:smart_admin_dashboard/screens/dashboard/components/recent_users.dart';
import 'package:smart_admin_dashboard/screens/dashboard/components/user_details_widget.dart';
import 'package:flutter/material.dart';

import '../loansApplication/loansTable.dart';
import 'components/header.dart';


class DashboardScreen extends StatefulWidget {
  final firstName;
  final lastName;
  const DashboardScreen({Key? key, required this.lastName, required this.firstName}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var token;
  var firstName;
  var lastName;

  getTokenNames() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    setState(() {
      token = _prefs.get('token');
      firstName = _prefs.getString('firstName');
      lastName=_prefs.getString('lastName');

      debugPrint('token is>>>>$token');
      debugPrint('fisrtName is>>>>$firstName');

    });

  }
  @override
  void initState() {
    getTokenNames();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        //padding: EdgeInsets.all(defaultPadding),
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(firstName: widget.firstName, lastName: widget.lastName,),
              SizedBox(height: defaultPadding),
              MiniInformation(),
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        //MyFiels(),
                        //SizedBox(height: defaultPadding),
                        LoanApplication(token: token,),
                        SizedBox(height: defaultPadding),
                        RecentDiscussions(),
                        if (Responsive.isMobile(context))
                          SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context)) UserDetailsWidget(),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: defaultPadding),
                  // On Mobile means if the screen is less than 850 we dont want to show it
                  // if (!Responsive.isMobile(context))
                    // Expanded(
                    //   flex: 2,
                    //   child: UserDetailsWidget(),
                    // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  }



import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_admin_dashboard/screens/users/UsersTable.dart';

import '../dashboard/components/header.dart';

class User_Screen extends StatefulWidget {
  const User_Screen({Key? key}) : super(key: key);

  @override
  State<User_Screen> createState() => _User_ScreenState();
}

class _User_ScreenState extends State<User_Screen> {
  var token, firstName, lastName;

  getNames() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      token = _prefs.get('token');
      firstName = _prefs.getString('firstName');
      lastName = _prefs.getString('lastName');
    });
    debugPrint('token is>>>>$token');
    debugPrint('fisrtName is>>>>$firstName');
  }

  @override
  void initState() {
    getNames();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header(
            firstName: firstName,
            lastName: lastName,
          ),
          UsersTable(token: token)
        ],
      ),
    );
  }
}

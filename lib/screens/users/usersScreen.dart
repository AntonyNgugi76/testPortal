import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_admin_dashboard/screens/home/components/side_menu.dart';

import '../../responsive.dart';
import 'User_Screen.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreen();
}

class _UsersScreen extends State<UsersScreen> {
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
              child: User_Screen(

              ),
            ),
          ],
        ),
      ),
    );
  }
}

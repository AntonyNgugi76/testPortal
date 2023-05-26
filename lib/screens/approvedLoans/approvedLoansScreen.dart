import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_admin_dashboard/screens/approvedLoans/approvedLoans.dart';
import 'package:smart_admin_dashboard/screens/home/components/side_menu.dart';

import '../../responsive.dart';


class ApprovedloansScreen extends StatefulWidget {
  const ApprovedloansScreen({Key? key}) : super(key: key);

  @override
  State<ApprovedloansScreen> createState() => _ApprovedloansScreenState();
}

class _ApprovedloansScreenState extends State<ApprovedloansScreen> {
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
              child: ApprovedLoans(

              ),
            ),
          ],
        ),
      ),
    );
  }
}

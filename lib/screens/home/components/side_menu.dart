import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_admin_dashboard/screens/approvedLoans/approvedLoansScreen.dart';
import 'package:smart_admin_dashboard/screens/home/home_screen.dart';
import 'package:smart_admin_dashboard/screens/loansApplication/loanApplicationScreen.dart';
import 'package:smart_admin_dashboard/screens/sheFunds/seedFundApplicationScreen.dart';
import 'package:smart_admin_dashboard/screens/users/usersScreen.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        // it enables scrolling
        child: Column(
          children: [
            DrawerHeader(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: defaultPadding * 3,
                ),
                const CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 23,
                  child: CircleAvatar(
                    radius: 23,
                    backgroundImage: AssetImage('images/logo.png'),
                  ),
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                Text("SHEBNKS V1 DASHBOARD")
              ],
            )),
            DrawerListTile(
              title: "Dashboard",
              svgSrc: "assets/icons/menu_dashbord.svg",
              press: () {
                    Get.off(() => HomeScreen());
              },
            ),
            DrawerListTile(
              title: "Loan Applications",
              svgSrc: "assets/icons/menu_tran.svg",
              press: () {
                Get.off(() => LoanApplicationsScreen());
              },
            ),
            DrawerListTile(
              title: "Approved Loans",
              svgSrc: "assets/icons/menu_task.svg",
              press: () {
                Get.off(ApprovedloansScreen());
              },
            ),
            DrawerListTile(
              title: "Disbursed Loans",
              svgSrc: "assets/icons/menu_doc.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Loan Repayments",
              svgSrc: "assets/icons/menu_store.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "SheFunds",
              svgSrc: "assets/icons/menu_notification.svg",
              press: () {
                Get.off(() => SeedFundApplicationScreen());
              },
            ),
            DrawerListTile(
              title: "SheIQ",
              svgSrc: "assets/icons/menu_profile.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Users",
              svgSrc: "assets/icons/menu_profile.svg",
              press: () {
                Get.off(() => UsersScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}

import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:smart_admin_dashboard/core/init/provider_list.dart';
import 'package:smart_admin_dashboard/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

Widget build(BuildContext context) {
  // return MultiProvider(
  //     providers: [...ApplicationProvider.instance.dependItems],
  //     child: FutureBuilder(
  //       builder: (context, snapshot) {
          return MyApp();
        // },
      // ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SheBnks Dashboard V1 ',
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(backgroundColor: bgColor, elevation: 0),
        scaffoldBackgroundColor: bgColor,
        primaryColor: greenColor,
        useMaterial3:  true,
        dialogBackgroundColor: secondaryColor,
        // buttonColor: greenColor,
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: Login(title: "Welcome to the SheBnks Admin"),
    );
  }
}

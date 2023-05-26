import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_admin_dashboard/screens/sheFunds/SeedFundTypes.dart';
import 'package:smart_admin_dashboard/screens/sheFunds/seedFundTable.dart';

class SeedDash extends StatefulWidget {
  final token;

  const SeedDash({required this.token, Key? key}) : super(key: key);

  @override
  State<SeedDash> createState() => _SeedDashState();
}

class _SeedDashState extends State<SeedDash> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.white,
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      // itemCount: 2, // Number of items
      // itemBuilder: (BuildContext context, int index) {
      //   return _buildGridItem(); // Function to build each grid item
      // },
      children: [
        SizedBox(
          height: 10,
        ),
        InkWell(onTap: (){
          Get.offAll(()=>SeedFundTypes(token: widget.token
          ));
        },child: Container(
          padding: EdgeInsets.all(20),
          height: 300,
          width: 250,
          child: _buildGridItem('Seed Funds', 'lottie/seedsapp.json'),
        )),
        SizedBox(
          height: 10,
        ),
        InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SeedFundTable(token: widget.token)));
            },
            child: Container(
              padding: EdgeInsets.all(20),
              height: 300,
              width: 250,
              child: _buildGridItem(
                  'Seed Fund Applications', 'lottie/seedsapp.json'),
            )),
      ],
    ));
  }

  Widget _buildGridItem(String text, String imagepath) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.pink)),
      // color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('$imagepath'),
          // Image.asset(imagepath), // Replace 'your_image_path' with the actual image path
          SizedBox(height: 8),
          // Optional spacing between image and text
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

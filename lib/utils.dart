import 'package:flutter/material.dart';

class Utils{
  static _showDialog(height, String message, BuildContext context){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        content: Container(
          height: height,
          child: Column(
            children: [
              Text(message),
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('OK'))

            ],
          ),
        ),
      );
    });
  }
}
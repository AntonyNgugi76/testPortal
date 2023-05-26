import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_admin_dashboard/screens/approvedLoans/approvedLoansTable.dart';
import 'package:smart_admin_dashboard/services/apiServices.dart';

import '../../models/loanApplicationModel.dart';
import '../dashboard/components/header.dart';


class ApprovedLoans extends StatefulWidget {
  const ApprovedLoans({Key? key}) : super(key: key);

  @override
  State<ApprovedLoans> createState() => _ApprovedLoansState();
}

class _ApprovedLoansState extends State<ApprovedLoans> {
  final APIServices _apiServices = APIServices();
  var token;
  var firstName;
  var lastName;



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
          ApprovedLoansTable(token: token)
        ],
      ),
    );
  }
}

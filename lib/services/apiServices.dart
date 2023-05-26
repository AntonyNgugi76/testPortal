import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:smart_admin_dashboard/models/ErrorModel.dart';
import 'package:smart_admin_dashboard/models/SeedModel.dart';
import 'package:smart_admin_dashboard/models/SuccessModel.dart';
import 'package:smart_admin_dashboard/models/approvedModel.dart';
import 'package:smart_admin_dashboard/models/loanApplicationModel.dart';
import 'package:smart_admin_dashboard/models/loginModel.dart';

import '../models/SeedFundModel.dart';
import '../models/usersModel.dart';

class APIServices {
  //live
  String  base_url='http://142.93.40.69:8090/she/api/v1';
  //test
  // final String base_url = 'http://192.168.137.202:8080/she/api/v1';
  // String  base_url='http://192.168.137.202:8080/she/api/v1';
  // String base_url = 'http://192.168.152.238:8080/she/api/v1/user/auth/login';

  // String baseUrl = 'https://cors-anywhere.herokuapp.com';
  // String actualUrl = 'http://142.93.40.69:8090/she/api/v1/users/auth/login';


  adminLogin(Map data) async {
    String finalUrl = "$base_url/user/auth/login";
    // var uri = Uri.https('http://192.168.152.238:8080/', 'she/api/v1/user/auth/login');
    Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': '*/*',
    "Access-Control-Allow-Origin": "*", // Required for CORS support to work
    "Access-Control-Allow-Credentials":
    'true', // Required for cookies, authorization headers with HTTPS
    "Access-Control-Allow-Headers":
    "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
    "Access-Control-Allow-Methods": "POST, OPTIONS",

    };
    debugPrint("RequestBody is>>>>>>${data}");
    debugPrint("url is>>>>>>${finalUrl}");
    try{
    final response = await http.post(Uri.parse(finalUrl),
    headers: header, body: jsonEncode(data));

    debugPrint("Response is>>>>>>${response.body}");
    if (response.statusCode == 200) {
    return LoginModel.fromJson(jsonDecode(response.body));
    } else {
    return ErrorModel.fromJson(jsonDecode(response.body));
    }

    } catch(e){
    print ('Error>>>>>${e.toString()}');
    }
  }

  Future<LoanApplicationModel> getAllLoans(String _token) async{
    String finalUrl = base_url+'/loan/all';
    debugPrint("url is>>>>>>${finalUrl}");

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${_token}',
    };
    final response =await http.get(Uri.parse(finalUrl), headers: headers);
    debugPrint("Response is>>>>>>${response.body}");
    if(response.statusCode==200){
      return LoanApplicationModel.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to Load Data');
    }

  }

  Future<AllUsersModel?> getAllUsers(String _token) async{
    String finalUrl = base_url+'/user/all';
    debugPrint("url is>>>>>>${finalUrl}");
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${_token}',
    };
    final response =await http.get(Uri.parse(finalUrl), headers: headers);
    debugPrint("Response is>>>>>>${response.body}");
    if(response.statusCode==200){
      return AllUsersModel.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to Load Data');
    }

  }

  Future<SeedFundModel>getAllSeedFunds(String _token) async{
    String finalUrl = base_url+'/seed/all';

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${_token}',
    };
    final response =await http.get(Uri.parse(finalUrl), headers: headers);
    debugPrint("SeedResponse is>>>>>>${response.body}");
    if(response.statusCode==200){
      return SeedFundModel.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to Load Data');
    }

  }
  Future<SeedModel> getSeedFundTypes(String _token) async{
    String finalUrl = base_url+'/seed/fund/all';
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${_token}',
    };
    final response = await http.get(Uri.parse(finalUrl), headers: headers);
    debugPrint('Activation Response>>>>>${response.body}');
    if(response.statusCode==200){
      return SeedModel.fromJson(jsonDecode(response.body));
    }else{
      // return ErrorModel.fromJson(jsonDecode(response.body));
      throw Exception('Failed to load seedFunds');
    }

  }
  activateSeedFund(String _token, String _seedId) async{
    String finalUrl = base_url+'/seed/fund/activate/${_seedId}';
    debugPrint("URL>>>>>>>$finalUrl");
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${_token}',
    };
    final response = await http.put(Uri.parse(finalUrl), headers: headers);
    debugPrint('Activation Response>>>>>${response.body}');
    if(response.statusCode==200){
      return SuccessModel.fromJson(jsonDecode(response.body));
    }else{
      return ErrorModel.fromJson(jsonDecode(response.body));
    }


  }


  deactivateSeedFund(String _token, String _seedId) async{
  String finalUrl = base_url+'/seed/fund/deactivate/${_seedId}';
  debugPrint("URL>>>>>>>$finalUrl");
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${_token}',
  };
  final response = await http.put(Uri.parse(finalUrl), headers: headers);
  debugPrint('Deactivation Response>>>>>${response.body}');
  if(response.statusCode==200){
    return SuccessModel.fromJson(jsonDecode(response.body));
  }else{
    return ErrorModel.fromJson(jsonDecode(response.body));
  }


  }
  approveSeedFund(String _token, String _seedId) async{
    String finalUrl = base_url+'/seed/approve/${_seedId}';
    debugPrint("URL>>>>>>>$finalUrl");
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${_token}',
    };
    final response = await http.put(Uri.parse(finalUrl), headers: headers);
    debugPrint('Seed approval Response>>>>>${response.body}');
    if(response.statusCode==200){
      return SuccessModel.fromJson(jsonDecode(response.body));
    }else{
      return ErrorModel.fromJson(jsonDecode(response.body));
    }


  }
  denySeedFund(String _token, String _seedId) async{

    String finalUrl = base_url+'/seed/reject/${_seedId}';
    debugPrint("URL>>>>>>>$finalUrl");
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${_token}',
    };
    final response = await http.put(Uri.parse(finalUrl), headers: headers);
    debugPrint('Seed denial Response>>>>>${response.body}');
    if(response.statusCode==200){
      return SuccessModel.fromJson(jsonDecode(response.body));
    }else{
      return ErrorModel.fromJson(jsonDecode(response.body));
    }

  }
  approveLoan(String _loanId, String _token) async{
    String finalUrl = base_url+'/loan/approve/${_loanId}';
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${_token}',
    };
    debugPrint("URL>>>>>>>$finalUrl");
    final response = await http.put(Uri.parse(finalUrl), headers: headers);
    debugPrint('Seed denial Response>>>>>${response.body}');
    if(response.statusCode==200){
      return SuccessModel.fromJson(jsonDecode(response.body));
    }else{
      return ErrorModel.fromJson(jsonDecode(response.body));
    }

  }
  denyLoan(String _loanId, String _token) async{
    String finalUrl = base_url+'/loan/reject/${_loanId}';
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${_token}',
    };
    debugPrint("URL>>>>>>>$finalUrl");
    final response = await http.put(Uri.parse(finalUrl), headers: headers);
    debugPrint('Seed denial Response>>>>>${response.body}');
    if(response.statusCode==200){
      return SuccessModel.fromJson(jsonDecode(response.body));
    }else{
      return ErrorModel.fromJson(jsonDecode(response.body));
    }
  }

   Future<ApprovedLoansModel> getAllApprovedLoans(String _token) async {
    String finalUrl = base_url+'/loan/approved';
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${_token}',
    };
    debugPrint("URL>>>>>>>$finalUrl");
    final response = await http.get(Uri.parse(finalUrl), headers: headers);
    debugPrint('Approved Loans Response>>>>>${response.body}');
    if(response.statusCode==200){
      return ApprovedLoansModel.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to Load Data');
    }

  }



}
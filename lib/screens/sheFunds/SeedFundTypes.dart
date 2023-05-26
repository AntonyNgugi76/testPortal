import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_admin_dashboard/models/SeedFundModel.dart';
import 'package:smart_admin_dashboard/models/SeedModel.dart';
import 'package:smart_admin_dashboard/models/usersModel.dart';

import '../../core/constants/color_constants.dart';
import '../../responsive.dart';
import '../../services/apiServices.dart';
import '../home/components/side_menu.dart';

class SeedFundTypes extends StatefulWidget {
  final token;

  const SeedFundTypes({Key? key, required this.token}) : super(key: key);

  @override
  State<SeedFundTypes> createState() => _SeedFundTypesState();
}

class _SeedFundTypesState extends State<SeedFundTypes> {
  final APIServices _apiServices = APIServices();
  late SeedModel seedModel;

  // var textButton;
  var seeds;
  var _seedId;
  var buttonText;

  // var token;
  var aText;

  // getToken() async {
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     token = _prefs.get('token');
  //   });
  // }

  //  getSeedStatus() async{
  //    await _apiServices.getSeedFundTypes(widget.token).then((value) {
  //      setState(() {
  //        textButton = value.data?[0].status;
  //        seedId = value.data?[0].seedId;
  //      });
  //
  //       debugPrint('textButton>>>>>$textButton');
  //       debugPrint('SeedID>>>>>$seedId');
  //   });
  // }

  determineAction(String text) {
    if (text == "ACTIVE") {
      // setState(() {
        buttonText = "Deactivate";
      // });
    } else {
      // setState(() {
        buttonText = "Activate";
      // });
    }
  }

  @override
  void initState() {
    // getSeedStatus();
    // getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
                child: Container(
                  padding: EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "Available Seed Funds",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .subtitle1,
                            ),
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                          child: FutureBuilder<SeedModel?>(
                              future:
                              _apiServices.getSeedFundTypes(widget.token),
                              builder: (context,
                                  AsyncSnapshot<SeedModel?> snapshot) {
                                debugPrint(
                                    'SeedTypes>>>>>>>>${snapshot.data?.data}');
                                debugPrint('token>>>>>>>>${widget.token}');
                                Widget child = CircularProgressIndicator(
                                  color: Colors.pink,
                                );

                                //scrollDirection: Axis.horizontal,
                                if (snapshot.hasData) {
                                  seeds = snapshot.data?.data;
                                  debugPrint(
                                      'seeds>>>>>>>>${seeds.toString()}');
                                  // setState(() {
                                  // seeId = snapshot.data?.data?[0].id;
                                  _seedId = snapshot.data?.data![0].seedId;
                                  aText = snapshot.data?.data![0].status;
                                  determineAction(aText);

                                  // });

                                  // debugPrint('seedid>>>>>>$seeId');
                                  // storeId(seedId);

                                  child = SizedBox(
                                    width: double.infinity,
                                    child: DataTable(
                                      horizontalMargin: 0,
                                      columnSpacing: defaultPadding,
                                      columns: [
                                        DataColumn(
                                          label: Text("Seed Name"),
                                        ),
                                        DataColumn(
                                          label: Text("Seed ID"),
                                        ),
                                        DataColumn(
                                          label: Text("Period"),
                                        ),
                                        DataColumn(
                                          label: Text("Status"),
                                        ),
                                        DataColumn(
                                          label: Text("Actions"),
                                        ),
                                      ],
                                      rows: List<DataRow>.generate(
                                          seeds.length,
                                              (index) =>
                                              DataRow(
                                                cells: [
                                                  DataCell(
                                                      Text(seeds[index].name)),
                                                  DataCell(Text(
                                                      seeds[index].seedId)),
                                                  DataCell(Text(
                                                      '${seeds[index].period
                                                          .toString()} Months')),
                                                  DataCell(Text(
                                                      '${seeds[index].status
                                                          .toString()} ')),
                                                  DataCell(OutlinedButton(
                                                    onPressed: () {
                                                      if (aText == "ACTIVE") {
                                                        _apiServices
                                                            .deactivateSeedFund(
                                                            widget.token,
                                                            _seedId).then((
                                                            value) {
                                                              if(value.status == "OK"){
                                                                _showDialog(value.message.toString());
                                                              }
                                                              else{
                                                                _showDialog(value.message.toString());
                                                              }


                                                        });
                                                      }
                                                      else{
                                                        _apiServices.activateSeedFund(widget.token, _seedId).then((value){
                                                          if(value.status=="0k"){
                                                            _showDialog(value.message.toString());
                                                          }
                                                          else{
                                                            _showDialog(value.message.toString());

                                                          }
                                                        });
                                                      }
                                                    },
                                                    child: Text(buttonText),
                                                  ))
                                                ],
                                              )
                                        // recentUserDataRow(recentUsers[index], context),
                                      ),
                                    ),
                                  );
                                } else
                                  return (Center(
                                    child: Text('No records Found'),
                                  ));
                                return child;
                              })),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
  void _showDialog(String message){
    showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        height: MediaQuery.of(context).size.height *
                            0.15,
                        child: Column(
                          children: [
                            Text('${message}'),
                            SizedBox(
                              height: 30,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  setState(() {
                                  });
                                },
                                child: Text('OK'))
                          ],
                        ),
                      ),
                    );
                  });
  }
}

// getSeedStatus();
// determineAction(textButton);

// return Container
// (
// padding: EdgeInsets.all(defaultPadding),
// decoration: BoxDecoration(
// color: secondaryColor,
// borderRadius: const BorderRadius.all(Radius.circular(10)),
// ),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Container(
// child: Text(
// "Seed Fund Appplications",
// style: Theme.of(context).textTheme.subtitle1,
// ),
// ),
//
// // FutureBuilder<SeedModel>(
// //   future: _apiServices.getSeedFundTypes(token),
// //     builder: (BuildContext, AsyncSnapshot<SeedModel> snapshot){
// //     Widget child = CircularProgressIndicator(color: Colors.pink,);
// //     if(snapshot.hasData){
// //       seedModel= snapshot.data!;
// //       debugPrint('SeedFundTypes>>>>>>>>>$seedModel');
// //
// //     }
// //     return child;
// //
// //     }),
// // Container(
// //     child: Row(
// //   children: [
// //     ElevatedButton.icon(
// //       style: TextButton.styleFrom(
// //         backgroundColor: Colors.green,
// //         padding: EdgeInsets.symmetric(
// //           horizontal: defaultPadding * 1.5,
// //           vertical: defaultPadding /
// //               (Responsive.isMobile(context) ? 2 : 1),
// //         ),
// //       ),
// //       onPressed: () {
// //         debugPrint('SeedID>>>>>$seedId');
// //         if(textButton=="ACTIVE"){
// //           _apiServices.deactivateSeedFund(token, seedId).then((value) {
// //             debugPrint('$value');
// //             if (value.status == 'OK') {
// //               showDialog(
// //                   context: context,
// //                   builder: (BuildContext context) {
// //                     return AlertDialog(
// //                       content: Container(
// //                         height: MediaQuery.of(context).size.height *
// //                             0.2,
// //                         child: Column(
// //                           children: [
// //                             Text('${value.message.toString()}'),
// //                             SizedBox(
// //                               height: 30,
// //                             ),
// //                             TextButton(
// //                                 onPressed: () {
// //                                   Navigator.pop(context);
// //                                 },
// //                                 child: Text('OK'))
// //                           ],
// //                         ),
// //                       ),
// //                     );
// //                   });
// //             } else {
// //               showDialog(
// //                   context: context,
// //                   builder: (BuildContext context) {
// //                     return AlertDialog(
// //                       content: Container(
// //                         height: MediaQuery.of(context).size.height *
// //                             0.2,
// //                         child: Column(
// //                           children: [
// //                             Text('${value.message.toString()}'),
// //                             SizedBox(
// //                               height: 30,
// //                             ),
// //                             TextButton(
// //                                 onPressed: () {
// //                                   Navigator.pop(context);
// //                                 },
// //                                 child: Text('OK'))
// //                           ],
// //                         ),
// //                       ),
// //                     );
// //                   });
// //             }
// //           });
// //         }else{
// //           _apiServices.activateSeedFund(token, seedId).then((value) {
// //             debugPrint('$value');
// //             if (value.status == 'OK') {
// //               showDialog(
// //                   context: context,
// //                   builder: (BuildContext context) {
// //                     return AlertDialog(
// //                       content: Container(
// //                         height: MediaQuery.of(context).size.height *
// //                             0.2,
// //                         child: Column(
// //                           children: [
// //                             Text('${value.message.toString()}'),
// //                             SizedBox(
// //                               height: 30,
// //                             ),
// //                             TextButton(
// //                                 onPressed: () {
// //                                   Navigator.pop(context);
// //                                 },
// //                                 child: Text('OK'))
// //                           ],
// //                         ),
// //                       ),
// //                     );
// //                   });
// //             }
// //             else {
// //               showDialog(
// //                   context: context,
// //                   builder: (BuildContext context) {
// //                     return AlertDialog(
// //                       content: Container(
// //                         height: MediaQuery.of(context).size.height *
// //                             0.2,
// //                         child: Column(
// //                           children: [
// //                             Text('${value.message.toString()}'),
// //                             SizedBox(
// //                               height: 30,
// //                             ),
// //                             TextButton(
// //                                 onPressed: () {
// //                                   Navigator.pop(context);
// //                                 },
// //                                 child: Text('OK'))
// //                           ],
// //                         ),
// //                       ),
// //                     );
// //                   });
// //             }
// //           });
// //
// //         }
// //       },
// //       icon: Icon(Icons.check_box_outlined),
// //       label: Text(
// //         '$aText',
// //       ),
// //     ),
// //     // ElevatedButton.icon(
// //     //   style: TextButton.styleFrom(
// //     //     backgroundColor: Colors.red,
// //     //     padding: EdgeInsets.symmetric(
// //     //       horizontal: defaultPadding * 1.5,
// //     //       vertical: defaultPadding /
// //     //           (Responsive.isMobile(context) ? 2 : 1),
// //     //     ),
// //     //   ),
// //     //   onPressed: () {},
// //     //   icon: Icon(Icons.stop_circle_outlined),
// //     //   label: Text(
// //     //     "Deactivate",
// //     //   ),
// //     // ),
// //   ],
// // )),
// ],
// ),
// SingleChildScrollView(
// child: FutureBuilder<SeedFundModel?>(
// future: _apiServices.getAllSeedFunds(widget.token),
// builder: (context, AsyncSnapshot<SeedFundModel?> snapshot) {
// debugPrint('SeedSnapshotData>>>>>>>>${snapshot.data}');
// debugPrint('token>>>>>>>>${widget.token}');
// Widget child = CircularProgressIndicator(
// color: Colors.pink,
// );
//
// //scrollDirection: Axis.horizontal,
// if (snapshot.hasData) {
// seeds = snapshot.data?.data?.seedFunds;
// debugPrint('seeds>>>>>>>>${seeds.toString()}');
// // setState(() {
// // seeId = snapshot.data?.data?.seedFunds![0].id;
//
// // });
//
// // debugPrint('seedid>>>>>>$seeId');
// // storeId(seedId);
//
// child = SizedBox(
// width: double.infinity,
// child: DataTable(
// horizontalMargin: 0,
// columnSpacing: defaultPadding,
// columns: [
// DataColumn(
// label: Text("First Name"),
// ),
// DataColumn(
// label: Text("Last Name"),
// ),
// DataColumn(
// label: Text("Seed ID"),
// ),
// DataColumn(
// label: Text("Action"),
// ),
// ],
// rows: List<DataRow>.generate(
// seeds.length,
// (index) => DataRow(
// cells: [
// DataCell(
// Text(seeds[index].user.firstName)),
// DataCell(
// Text(seeds[index].user.lastName)),
// DataCell(Text(seeds[index].id)),
// DataCell(TextButton(
// onPressed: () {},
// child: Text('View More'),
// ))
// ],
// )
// // recentUserDataRow(recentUsers[index], context),
// ),
// ),
// );
// } else
// return (Center(
// child: Text('No records Found'),
// ));
// return child;
// })
// )
// ,
// ]
// ,
// )
// ,
// );
//

import 'package:flutter/cupertino.dart';
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

class SeedFundTable extends StatefulWidget {
  final token;

  const SeedFundTable({Key? key, required this.token}) : super(key: key);

  @override
  State<SeedFundTable> createState() => _SeedFundTableState();
}

class _SeedFundTableState extends State<SeedFundTable> {
  final APIServices _apiServices = APIServices();
  late SeedModel seedModel;

  // var textButton;
  var seeds;
  var singleSeedId;
  var seedId;

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

  @override
  void initState() {
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
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(),
              ),
            Expanded(
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
                              "Seed Fund Appplications",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                          child: FutureBuilder<SeedFundModel?>(
                              future:
                                  _apiServices.getAllSeedFunds(widget.token),
                              builder: (context,
                                  AsyncSnapshot<SeedFundModel?> snapshot) {
                                debugPrint(
                                    'SeedSnapshotData>>>>>>>>${snapshot.data}');
                                debugPrint('token>>>>>>>>${widget.token}');
                                Widget child = CircularProgressIndicator(
                                  color: Colors.pink,
                                );

                                //scrollDirection: Axis.horizontal,
                                if (snapshot.hasData) {
                                  seeds = snapshot.data?.data?.seedFunds;
                                  debugPrint(
                                      'seeds>>>>>>>>${seeds.toString()}');
                                  // setState(() {
                                  // seeId = snapshot.data?.data?.seedFunds![0].id;

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
                                          label: Text("First Name"),
                                        ),
                                        DataColumn(
                                          label: Text("Last Name"),
                                        ),
                                        DataColumn(
                                          label: Text("Seed ID"),
                                        ),
                                        DataColumn(
                                          label: Text("Action"),
                                        ),
                                      ],
                                      rows: List<DataRow>.generate(
                                          seeds.length,
                                          (index) => DataRow(
                                                cells: [
                                                  DataCell(Text(seeds[index]
                                                      .user
                                                      .firstName)),
                                                  DataCell(Text(seeds[index]
                                                      .user
                                                      .lastName)),
                                                  DataCell(
                                                      Text(seeds[index].id)),
                                                  DataCell(TextButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                                content:
                                                                    SizedBox(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.7,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.6,
                                                              child: ListView
                                                                  .builder(
                                                                      scrollDirection:
                                                                          Axis
                                                                              .vertical,
                                                                      itemCount:
                                                                          seeds
                                                                              .length,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index) {
                                                                        singleSeedId= seeds[index].id;
                                                                        debugPrint('SeedId>>>>>$singleSeedId');
                                                                        return Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text('Name: ${seeds[index].user.firstName} ${seeds[index].user.lastName}'),
                                                                            Divider(
                                                                              height: 1,
                                                                            ),
                                                                            SizedBox(height: 5),
                                                                            Text('Responses'),
                                                                            SizedBox(height: 5),

                                                                            Divider(
                                                                              height: 1,
                                                                            ),

                                                                            SizedBox(height: 5),
                                                                            Text('1. Brief About the organization:    ${seeds[index].about}'),
                                                                            SizedBox(height: 5),
                                                                            Text('2. Trusted Founder:   ${seeds[index].founders}'),
                                                                            SizedBox(height: 5),
                                                                            Text('3. Sectors of Operation     ${seeds[index].sectors}'),
                                                                            SizedBox(height: 5),
                                                                            Text('4. Is it woman Owned    ${seeds[index].womanOwned}'),
                                                                            SizedBox(height: 5),
                                                                            Text('5. Bridging gender gap/STEM:    ${seeds[index].bridging}'),
                                                                            SizedBox(height: 5),
                                                                            Text('6. Problems being addressed:    ${seeds[index].problems}'),
                                                                            SizedBox(height: 5),
                                                                            Text('7. Measure impact:    ${seeds[index].impact}'),
                                                                            SizedBox(height: 5),
                                                                            Text('8. SDG being targeted:    ${seeds[index].primaryTarget}'),
                                                                            SizedBox(height: 5),
                                                                            Text('9. marketing Strategy:    ${seeds[index].marketing}'),
                                                                            SizedBox(height: 5),
                                                                            Text('10. Applied On:    ${seeds[index].appliedOn}'),
                                                                            SizedBox(height: 5),
                                                                            Text('11. STEM Initiative achieved:   ${seeds[index].stemInitiative}'),
                                                                            SizedBox(height: 5),
                                                                            Text('12. Proven transactions   ${seeds[index].provenTransaction}'),
                                                                            SizedBox(height: 5),
                                                                            Text('13.Ever Fundraised before:    ${seeds[index].fundraised}'),
                                                                            SizedBox(height: 5),
                                                                            Text('14 Why Should we fund you:    ${seeds[index].reason}'),
                                                                            SizedBox(height: 5),
                                                                            Text('15. Any other information:    ${seeds[index].otherInfo}'),
                                                                            // Text('18. problems'),
                                                                            SizedBox(height: 5),
                                                                            Text('16. status:   ${seeds[index].status}'),
                                                                            SizedBox(height: 20),
                                                                            // {this.reason,
                                                                            // this.otherInfo,
                                                                            // this.sectors,
                                                                            // this.impact,
                                                                            // this.about,
                                                                            // this.founders,
                                                                            // this.stemInitiative,
                                                                            // this.womanOwned,
                                                                            // this.marketing,
                                                                            // this.appliedOn,
                                                                            // this.fundraised,
                                                                            // this.primaryTarget,
                                                                            // this.provenTransaction,
                                                                            // this.id,
                                                                            // this.user,
                                                                            // this.bridging,
                                                                            // this.problems,

                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                ElevatedButton.icon(onPressed: (){
                                                                                  _apiServices.approveSeedFund(widget.token, singleSeedId).then((value){
                                                                                    debugPrint('value${value.toString()}');
                                                                                    setState(() {

                                                                                    });
                                                                                    if(value.status=='OK'){
                                                                                      _showDialog(value.message.toString());
                                                                                    }else{
                                                                                      _showDialog(value.message.toString());
                                                                                    }

                                                                                  });
                                                                                }, icon: Icon(Icons.check_box_outlined)
                                                                                    ,label: Text('Approve'),
                                                                                  style: ElevatedButton.styleFrom(
                                                                                    primary: Colors.green
                                                                                        .withOpacity(0.5),
                                                                                  ),


                                                                                    ),
                                                                                SizedBox(width: 20,),
                                                                                ElevatedButton.icon(onPressed: (){
                                                                                  _apiServices.denySeedFund(widget.token, singleSeedId).then((value){
                                                                                    debugPrint('value${value.toString()}');
                                                                                    if(value.status=='OK'){
                                                                                      _showDialog(value.message.toString());
                                                                                    }else{
                                                                                      _showDialog(value.message.toString());
                                                                                    }

                                                                                  });

                                                                                },style: ElevatedButton.styleFrom(
                                                                                  primary: Colors.red
                                                                                      .withOpacity(0.5),
                                                                                ), label: Text('Deny'), icon: Icon(Icons.cancel_outlined),),
                                                                              ],
                                                                            )
                                                                          ],
                                                                        );
                                                                      }),
                                                            ));
                                                          });
                                                    },
                                                    child: Text('View More'),
                                                  ))
                                                ],
                                              )
                                          // recentUserDataRow(recentUsers[index], context),
                                          ),
                                    ),
                                  );
                                } else
                                  return (Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.pink,
                                    ),
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
    // getSeedStatus();
    // determineAction(textButton);

    return Container(
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
                  "Seed Fund Appplications",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),

              // FutureBuilder<SeedModel>(
              //   future: _apiServices.getSeedFundTypes(token),
              //     builder: (BuildContext, AsyncSnapshot<SeedModel> snapshot){
              //     Widget child = CircularProgressIndicator(color: Colors.pink,);
              //     if(snapshot.hasData){
              //       seedModel= snapshot.data!;
              //       debugPrint('SeedFundTypes>>>>>>>>>$seedModel');
              //
              //     }
              //     return child;
              //
              //     }),
              // Container(
              //     child: Row(
              //   children: [
              //     ElevatedButton.icon(
              //       style: TextButton.styleFrom(
              //         backgroundColor: Colors.green,
              //         padding: EdgeInsets.symmetric(
              //           horizontal: defaultPadding * 1.5,
              //           vertical: defaultPadding /
              //               (Responsive.isMobile(context) ? 2 : 1),
              //         ),
              //       ),
              //       onPressed: () {
              //         debugPrint('SeedID>>>>>$seedId');
              //         if(textButton=="ACTIVE"){
              //           _apiServices.deactivateSeedFund(token, seedId).then((value) {
              //             debugPrint('$value');
              //             if (value.status == 'OK') {
              //               showDialog(
              //                   context: context,
              //                   builder: (BuildContext context) {
              //                     return AlertDialog(
              //                       content: Container(
              //                         height: MediaQuery.of(context).size.height *
              //                             0.2,
              //                         child: Column(
              //                           children: [
              //                             Text('${value.message.toString()}'),
              //                             SizedBox(
              //                               height: 30,
              //                             ),
              //                             TextButton(
              //                                 onPressed: () {
              //                                   Navigator.pop(context);
              //                                 },
              //                                 child: Text('OK'))
              //                           ],
              //                         ),
              //                       ),
              //                     );
              //                   });
              //             } else {
              //               showDialog(
              //                   context: context,
              //                   builder: (BuildContext context) {
              //                     return AlertDialog(
              //                       content: Container(
              //                         height: MediaQuery.of(context).size.height *
              //                             0.2,
              //                         child: Column(
              //                           children: [
              //                             Text('${value.message.toString()}'),
              //                             SizedBox(
              //                               height: 30,
              //                             ),
              //                             TextButton(
              //                                 onPressed: () {
              //                                   Navigator.pop(context);
              //                                 },
              //                                 child: Text('OK'))
              //                           ],
              //                         ),
              //                       ),
              //                     );
              //                   });
              //             }
              //           });
              //         }else{
              //           _apiServices.activateSeedFund(token, seedId).then((value) {
              //             debugPrint('$value');
              //             if (value.status == 'OK') {
              //               showDialog(
              //                   context: context,
              //                   builder: (BuildContext context) {
              //                     return AlertDialog(
              //                       content: Container(
              //                         height: MediaQuery.of(context).size.height *
              //                             0.2,
              //                         child: Column(
              //                           children: [
              //                             Text('${value.message.toString()}'),
              //                             SizedBox(
              //                               height: 30,
              //                             ),
              //                             TextButton(
              //                                 onPressed: () {
              //                                   Navigator.pop(context);
              //                                 },
              //                                 child: Text('OK'))
              //                           ],
              //                         ),
              //                       ),
              //                     );
              //                   });
              //             }
              //             else {
              //               showDialog(
              //                   context: context,
              //                   builder: (BuildContext context) {
              //                     return AlertDialog(
              //                       content: Container(
              //                         height: MediaQuery.of(context).size.height *
              //                             0.2,
              //                         child: Column(
              //                           children: [
              //                             Text('${value.message.toString()}'),
              //                             SizedBox(
              //                               height: 30,
              //                             ),
              //                             TextButton(
              //                                 onPressed: () {
              //                                   Navigator.pop(context);
              //                                 },
              //                                 child: Text('OK'))
              //                           ],
              //                         ),
              //                       ),
              //                     );
              //                   });
              //             }
              //           });
              //
              //         }
              //       },
              //       icon: Icon(Icons.check_box_outlined),
              //       label: Text(
              //         '$aText',
              //       ),
              //     ),
              //     // ElevatedButton.icon(
              //     //   style: TextButton.styleFrom(
              //     //     backgroundColor: Colors.red,
              //     //     padding: EdgeInsets.symmetric(
              //     //       horizontal: defaultPadding * 1.5,
              //     //       vertical: defaultPadding /
              //     //           (Responsive.isMobile(context) ? 2 : 1),
              //     //     ),
              //     //   ),
              //     //   onPressed: () {},
              //     //   icon: Icon(Icons.stop_circle_outlined),
              //     //   label: Text(
              //     //     "Deactivate",
              //     //   ),
              //     // ),
              //   ],
              // )),
            ],
          ),
          SingleChildScrollView(
              child: FutureBuilder<SeedFundModel?>(
                  future: _apiServices.getAllSeedFunds(widget.token),
                  builder: (context, AsyncSnapshot<SeedFundModel?> snapshot) {
                    debugPrint('SeedSnapshotData>>>>>>>>${snapshot.data}');
                    debugPrint('token>>>>>>>>${widget.token}');
                    Widget child = CircularProgressIndicator(
                      color: Colors.pink,
                    );

                    //scrollDirection: Axis.horizontal,
                    if (snapshot.hasData) {
                      seeds = snapshot.data?.data?.seedFunds;
                      debugPrint('seeds>>>>>>>>${seeds.toString()}');
                      // setState(() {
                      // seeId = snapshot.data?.data?.seedFunds![0].id;

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
                              label: Text("First Name"),
                            ),
                            DataColumn(
                              label: Text("Last Name"),
                            ),
                            DataColumn(
                              label: Text("Seed ID"),
                            ),
                            DataColumn(
                              label: Text("Action"),
                            ),
                          ],
                          rows: List<DataRow>.generate(
                              seeds.length,
                              (index) => DataRow(
                                    cells: [
                                      DataCell(
                                          Text(seeds[index].user.firstName)),
                                      DataCell(
                                          Text(seeds[index].user.lastName)),
                                      DataCell(Text(seeds[index].id)),
                                      DataCell(TextButton(
                                        onPressed: () {},
                                        child: Text('View More'),
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
    );
  }

  void _showAlertDalog() {
    // return AlertDialog()
  }

  void approveSeed(token, singleSeedId) {
    _apiServices.activateSeedFund(token, singleSeedId);
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

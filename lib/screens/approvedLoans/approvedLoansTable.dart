import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:smart_admin_dashboard/models/approvedModel.dart';
import 'package:smart_admin_dashboard/models/loanApplicationModel.dart';

import '../../core/constants/color_constants.dart';
import '../../core/utils/colorful_tag.dart';
import '../../models/recent_user_model.dart';
import '../../services/apiServices.dart';

class ApprovedLoansTable extends StatefulWidget {
  final token;

  const ApprovedLoansTable({Key? key, required this.token}) : super(key: key);

  @override
  State<ApprovedLoansTable> createState() => _ApprovedLoansTableState();
}

class _ApprovedLoansTableState extends State<ApprovedLoansTable> {
  final APIServices _apiServices = APIServices();
  var loans;
  var loanId;
  // List<LoanApplicationModel> allLoans = [];
  //
  // Future<List<LoanApplicationModel>?> getAllLoans() async {
  //   loans = await _apiServices.getAllLoans(widget.token).then((value) {
  //     setState(() {
  //       loans.forEach((value) {
  //         allLoans.add(value);
  //       });
  //       debugPrint('AllLoans>>>>${allLoans.toString()}');
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Approved Loans",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SingleChildScrollView(
              child: FutureBuilder<ApprovedLoansModel?>(
                  future: _apiServices.getAllApprovedLoans(widget.token),
                  builder:
                      (context, AsyncSnapshot<ApprovedLoansModel?> snapshot) {
                    debugPrint('SnapshotData>>>>>>>>${snapshot.data}');
                    Widget child = CircularProgressIndicator(
                      color: Colors.pink,
                    );

                    //scrollDirection: Axis.horizontal,
                    if (snapshot.hasData) {
                      // loanId= snapshot.data?.data?.loans?[0].id;
                      var apploans = snapshot.data?.data?.loans;
                      debugPrint('approvedLoansSnapshot>>>>>$apploans');
                      child = SizedBox(
                        width: double.infinity,
                        child: DataTable(
                          horizontalMargin: 0,
                          columnSpacing: defaultPadding,
                          columns: [
                            DataColumn(
                              label: Text("Username"),
                            ),
                            DataColumn(
                              label: Text("Status"),
                            ),
                            DataColumn(
                              label: Text("Amount"),
                            ),
                            DataColumn(
                              label: Text("Date"),
                            ),
                            DataColumn(
                              label: Text("Operation"),
                            ),
                          ],
                          rows: List<DataRow>.generate(
                              apploans!.length,
                                  (index) => DataRow(
                                cells: [
                                  DataCell(Text(
                                      apploans[index].user!.firstName!)),
                                  DataCell(
                                      Text(apploans[index].status!)),
                                  DataCell(Text(apploans[index].amount!
                                      .toString())),
                                  DataCell(Text(
                                      apploans[index].appliedOn!
                                      .toString())),
                                  DataCell(
                                    Row(
                                      children: [
                                        ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.blue
                                                .withOpacity(0.5),
                                          ),
                                          icon: Icon(
                                            Icons.edit,
                                            size: 14,
                                          ),
                                          onPressed: () {
                                            // _apiServices.approveLoan(loanId, widget.token).then((value){
                                            //   setState(() {
                                            //
                                            //   });
                                            //   if(value.statu=='OK'){
                                            //     _showDialog(value.message.toString());
                                            //   }
                                            //   else{
                                            //     _showDialog(value.message.toString());
                                            //   }
                                            // });

                                          },
                                          // Edit
                                          label: Text("Disburse", style: TextStyle(color: Colors.white),),
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        // ElevatedButton.icon(
                                        //   style: ElevatedButton.styleFrom(
                                        //     primary: Colors.green
                                        //         .withOpacity(0.5),
                                        //   ),
                                        //   icon: Icon(
                                        //     Icons.visibility,
                                        //     size: 14,
                                        //   ),
                                        //   onPressed: () {
                                        //     showDialog(
                                        //         context: context,
                                        //         builder:
                                        //             (BuildContext context) {
                                        //           return
                                        //             // Container(
                                        //             //   color: Colors.white,
                                        //             //   child:
                                        //             Column(children: [
                                        //               Container(
                                        //                 width: MediaQuery.of(
                                        //                     context)
                                        //                     .size
                                        //                     .width *
                                        //                     0.5,
                                        //                 padding:
                                        //                 EdgeInsets.all(
                                        //                     10),
                                        //                 child: Row(
                                        //                   mainAxisAlignment:
                                        //                   MainAxisAlignment
                                        //                       .spaceBetween,
                                        //                   children: [
                                        //                     Text(
                                        //                       'User: ',
                                        //                       style: TextStyle(
                                        //                           fontSize:
                                        //                           25),
                                        //                     ),
                                        //                     Text(
                                        //                       '${loans.loans?[index].user?.firstName} ${loans.loans?[index].user?.lastName}',
                                        //                       style: TextStyle(
                                        //                           fontSize:
                                        //                           25),
                                        //                     ),
                                        //                   ],
                                        //                 ),
                                        //               ),
                                        //               Container(
                                        //                 width: MediaQuery.of(
                                        //                     context)
                                        //                     .size
                                        //                     .width *
                                        //                     0.5,
                                        //                 padding:
                                        //                 EdgeInsets.all(
                                        //                     10),
                                        //                 child: Row(
                                        //                   mainAxisAlignment:
                                        //                   MainAxisAlignment
                                        //                       .spaceBetween,
                                        //                   children: [
                                        //                     Text(
                                        //                       'Status: ',
                                        //                       style: TextStyle(
                                        //                           fontSize:
                                        //                           25),
                                        //                     ),
                                        //                     Text(
                                        //                       '${loans.loans?[index].status}',
                                        //                       style: TextStyle(
                                        //                           fontSize:
                                        //                           25),
                                        //                     ),
                                        //                   ],
                                        //                 ),
                                        //               ),
                                        //               Container(
                                        //                 width: MediaQuery.of(
                                        //                     context)
                                        //                     .size
                                        //                     .width *
                                        //                     0.5,
                                        //                 padding:
                                        //                 EdgeInsets.all(
                                        //                     10),
                                        //                 child: Row(
                                        //                   mainAxisAlignment:
                                        //                   MainAxisAlignment
                                        //                       .spaceBetween,
                                        //                   children: [
                                        //                     Text(
                                        //                       'Amount: ',
                                        //                       style: TextStyle(
                                        //                           fontSize:
                                        //                           25),
                                        //                     ),
                                        //                     Text(
                                        //                       '${loans.loans?[index].amount}',
                                        //                       style: TextStyle(
                                        //                           fontSize:
                                        //                           25),
                                        //                     ),
                                        //                   ],
                                        //                 ),
                                        //               ),
                                        //               Container(
                                        //                 width: MediaQuery.of(
                                        //                     context)
                                        //                     .size
                                        //                     .width *
                                        //                     0.5,
                                        //                 padding:
                                        //                 EdgeInsets.all(
                                        //                     10),
                                        //                 child: Row(
                                        //                   mainAxisAlignment:
                                        //                   MainAxisAlignment
                                        //                       .spaceBetween,
                                        //                   children: [
                                        //                     Text(
                                        //                       'Date Applied: ',
                                        //                       style: TextStyle(
                                        //                           fontSize:
                                        //                           25),
                                        //                     ),
                                        //                     Text(
                                        //                       '${loans.loans?[index].appliedOn}',
                                        //                       style: TextStyle(
                                        //                           fontSize:
                                        //                           25),
                                        //                     ),
                                        //                   ],
                                        //                 ),
                                        //               ),
                                        //               Container(
                                        //                 width: MediaQuery.of(
                                        //                     context)
                                        //                     .size
                                        //                     .width *
                                        //                     0.5,
                                        //                 padding:
                                        //                 EdgeInsets.all(
                                        //                     10),
                                        //                 child: Row(
                                        //                   mainAxisAlignment:
                                        //                   MainAxisAlignment
                                        //                       .spaceBetween,
                                        //                   children: [
                                        //                     Text(
                                        //                       'Reasons: ',
                                        //                       style: TextStyle(
                                        //                           fontSize:
                                        //                           25),
                                        //                     ),
                                        //                     // Text(
                                        //                     //   '1. Waridi Member: ${loans.loans?[index].survey
                                        //                     //       !.howAreYou!}',
                                        //                     //   style: TextStyle(
                                        //                     //       fontSize:
                                        //                     //           25),
                                        //                     // ),
                                        //                     // Text(
                                        //                     //   '2. Inventory size: ${loans.loans?[index].survey
                                        //                     //       !.welcomeHome}',
                                        //                     //   style: TextStyle(
                                        //                     //       fontSize:
                                        //                     //           25),
                                        //                     // ),
                                        //                   ],
                                        //                 ),
                                        //               ),
                                        //             ]
                                        //             );
                                        //         });
                                        //   },
                                        //   //View
                                        //   label: Text("View"),
                                        // ),
                                        // SizedBox(
                                        //   width: 6,
                                        // ),
                                        // ElevatedButton.icon(
                                        //   style: ElevatedButton.styleFrom(
                                        //     primary:
                                        //     Colors.red.withOpacity(0.5),
                                        //   ),
                                        //   icon: Icon(Icons.delete),
                                        //   onPressed: () {
                                        //     showDialog(
                                        //         context: context,
                                        //         builder: (_) {
                                        //           return AlertDialog(
                                        //               title: Center(
                                        //                 child: Text(
                                        //                     "Confirm Denial"),
                                        //               ),
                                        //               content: Container(
                                        //                 color:
                                        //                 secondaryColor,
                                        //                 height: 70,
                                        //                 child: Column(
                                        //                   children: [
                                        //                     Text(
                                        //                         "Are you sure want to deny '${loans.loans![index].user!.firstName}'?"),
                                        //                     SizedBox(
                                        //                       height: 16,
                                        //                     ),
                                        //                     Row(
                                        //                       mainAxisAlignment:
                                        //                       MainAxisAlignment
                                        //                           .center,
                                        //                       children: [
                                        //                         ElevatedButton.icon(
                                        //                             icon: Icon(
                                        //                               Icons
                                        //                                   .close,
                                        //                               size:
                                        //                               14,
                                        //                             ),
                                        //                             style: ElevatedButton.styleFrom(primary: Colors.grey),
                                        //                             onPressed: () {
                                        //                               Navigator.of(context)
                                        //                                   .pop();
                                        //                             },
                                        //                             label: Text("Cancel")),
                                        //                         SizedBox(
                                        //                           width: 20,
                                        //                         ),
                                        //                         ElevatedButton.icon(
                                        //                             icon: Icon(
                                        //                               Icons
                                        //                                   .delete,
                                        //                               size:
                                        //                               14,
                                        //                             ),
                                        //                             style: ElevatedButton.styleFrom(primary: Colors.red),
                                        //                             onPressed: () {
                                        //                               _apiServices.denyLoan(loanId, widget.token).then((value){
                                        //                                 setState(() {
                                        //
                                        //                                 });
                                        //                                 if(value.statu=='OK'){
                                        //                                   _showDialog(value.message.toString());
                                        //                                 }
                                        //                                 else{
                                        //                                   _showDialog(value.message.toString());
                                        //                                 }
                                        //                               });
                                        //                             },
                                        //                             label: Text("Deny"))
                                        //                       ],
                                        //                     )
                                        //                   ],
                                        //                 ),
                                        //               ));
                                        //         });
                                        //   },
                                        //   // Delete
                                        //   label: Text("Deny"),
                                        // ),
                                      ],
                                    ),
                                    // DataCell(Text(loans.loans![index].!.toString())),
                                  )
                                ],
                              )
                            // recentUserDataRow(recentUsers[index], context),
                          ),
                        ),
                      );
                    } else{
                      return CircularProgressIndicator(color: Colors.pink,);
                      // _showAlertDialog(
                      //    context, snapshot.data?.message);

                    }




                    return child;
                  })),
        ],
      ),
    );
  }
  void _showDialog(String message){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        content: Container(
            height: MediaQuery.of(context).size.height*0.27,

            child: Column(
                children: [
                  SizedBox(height: 24,),

                  Icon(Icons.warning_amber_rounded, size: 50, color: Colors.pink,),
                  SizedBox(height: 24,),
                  Text(message),
                  SizedBox(height: 24,),
                  OutlinedButton(onPressed: () {
                    Navigator.of(context).pop();
                  },
                      child: Text('Ok'))

                ]

            )),
      );

    });
  }

}

DataRow recentUserDataRow(RecentUser userInfo, BuildContext context) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            TextAvatar(
              size: 35,
              backgroundColor: Colors.white,
              textColor: Colors.white,
              fontSize: 14,
              upperCase: true,
              numberLetters: 1,
              shape: Shape.Rectangle,
              text: userInfo.name!,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(
                userInfo.name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      DataCell(Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: getRoleColor(userInfo.role).withOpacity(.2),
            border: Border.all(color: getRoleColor(userInfo.role)),
            borderRadius: BorderRadius.all(Radius.circular(5.0) //
            ),
          ),
          child: Text(userInfo.role!))),
      DataCell(Text(userInfo.email!)),
      DataCell(Text(userInfo.date!)),
      DataCell(Text(userInfo.posts!)),
      DataCell(
        Row(
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.withOpacity(0.5),
              ),
              icon: Icon(
                Icons.edit,
                size: 14,
              ),
              onPressed: () {
              },
              // Edit
              label: Text("Approve"),
            ),
            SizedBox(
              width: 6,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.green.withOpacity(0.5),
              ),
              icon: Icon(
                Icons.visibility,
                size: 14,
              ),
              onPressed: () {},
              //View
              label: Text("View"),
            ),
            SizedBox(
              width: 6,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.red.withOpacity(0.5),
              ),
              icon: Icon(Icons.delete),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                          title: Center(
                            child: Text("Confirm Denial"),
                          ),
                          content: Container(
                            color: secondaryColor,
                            height: 70,
                            child: Column(
                              children: [
                                Text(
                                    "Are you sure want to deny '${userInfo.name}'?"),
                                SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton.icon(
                                        icon: Icon(
                                          Icons.close,
                                          size: 14,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.grey),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        label: Text("Cancel")),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    ElevatedButton.icon(
                                        icon: Icon(
                                          Icons.delete,
                                          size: 14,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.red),
                                        onPressed: () {},
                                        label: Text("Deny"))
                                  ],
                                )
                              ],
                            ),
                          ));
                    });
              },
              // Delete
              label: Text("Deny"),
            ),
          ],
        ),
      ),
    ],
  );
}

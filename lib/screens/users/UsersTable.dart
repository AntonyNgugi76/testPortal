import 'package:flutter/material.dart';
import 'package:smart_admin_dashboard/models/usersModel.dart';

import '../../core/constants/color_constants.dart';
import '../../services/apiServices.dart';

class UsersTable extends StatefulWidget {
  final token;
  const UsersTable({Key? key, required this.token}) : super(key: key);

  @override
  State<UsersTable> createState() => _UsersTableState();
}

class _UsersTableState extends State<UsersTable> {
  final APIServices _apiServices = APIServices();
  var users;

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
            "Users",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SingleChildScrollView(
              child: FutureBuilder<AllUsersModel?>(
                  future: _apiServices.getAllUsers(widget.token),
                  builder:
                      (context, AsyncSnapshot<AllUsersModel?> snapshot) {
                    debugPrint('SnapshotData>>>>>>>>${snapshot.data}');
                    Widget child = CircularProgressIndicator(
                      color: Colors.pink,
                    );

                    //scrollDirection: Axis.horizontal,
                    if (snapshot.hasData) {
                       users = snapshot.data?.data?.users;
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
                              label: Text("Middle name"),
                            ),
                            DataColumn(
                              label: Text("Last Name"),
                            ),
                            DataColumn(
                              label: Text("Phone Number"),
                            ),
                            DataColumn(
                              label: Text("ID Number"),
                            ),
                            DataColumn(
                              label: Text("Email"),
                            ),
                          ],
                          rows: List<DataRow>.generate(
                              users.length,
                                  (index) => DataRow(
                                cells: [
                                  DataCell(Text(
                                      users[index].firstName)),
                                  DataCell(
                                      Text(users![index].middleName)),
                                  DataCell(Text(users[index].lastName
                                      .toString())),
                                  DataCell(Text(
                                      users![index].mobile
                                      .toString())),
                                  DataCell(Text(users[index].idNumber
                                      .toString())),DataCell(Text(users[index].email
                                      .toString())),

                                ],
                              )
                            // recentUserDataRow(recentUsers[index], context),
                          ),
                        ),
                      );
                    } else
                      return (Center(
                        child:  Text('No records Found'),

                      ));
                    return child;
                  })),
        ],
      ),
    );
  }
}


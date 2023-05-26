class AllUsersModel {
  String? message;
  String? status;
  Data? data;

  AllUsersModel({this.message, this.status, this.data});

  AllUsersModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Users>? users;

  Data({this.users});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  String? firstName;
  String? lastName;
  String? mobile;
  String? middleName;
  String? idNumber;
  String? userId;
  String? email;

  Users(
      {this.firstName,
        this.lastName,
        this.mobile,
        this.middleName,
        this.idNumber,
        this.userId,
        this.email});

  Users.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    middleName = json['middleName'];
    idNumber = json['idNumber'];
    userId = json['userId'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mobile'] = this.mobile;
    data['middleName'] = this.middleName;
    data['idNumber'] = this.idNumber;
    data['userId'] = this.userId;
    data['email'] = this.email;
    return data;
  }
}

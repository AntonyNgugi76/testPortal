class ApprovedLoansModel {
  String? message;
  String? status;
  Data? data;

  ApprovedLoansModel({this.message, this.status, this.data});

  ApprovedLoansModel.fromJson(Map<String, dynamic> json) {
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
  List<Loans>? loans;

  Data({this.loans});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['loans'] != null) {
      loans = <Loans>[];
      json['loans'].forEach((v) {
        loans!.add(new Loans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.loans != null) {
      data['loans'] = this.loans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Loans {
  int? amount;
  String? appliedOn;
  Survey? survey;
  String? id;
  Null? disbursedOn;
  User? user;
  String? status;

  Loans(
      {this.amount,
        this.appliedOn,
        this.survey,
        this.id,
        this.disbursedOn,
        this.user,
        this.status});

  Loans.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    appliedOn = json['appliedOn'];
    survey =
    json['survey'] != null ? new Survey.fromJson(json['survey']) : null;
    id = json['id'];
    disbursedOn = json['disbursedOn'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['appliedOn'] = this.appliedOn;
    if (this.survey != null) {
      data['survey'] = this.survey!.toJson();
    }
    data['id'] = this.id;
    data['disbursedOn'] = this.disbursedOn;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Survey {
  String? question1;

  Survey({this.question1});

  Survey.fromJson(Map<String, dynamic> json) {
    question1 = json['question1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question1'] = this.question1;
    return data;
  }
}

class User {
  String? firstName;
  String? lastName;
  String? userId;

  User({this.firstName, this.lastName, this.userId});

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['userId'] = this.userId;
    return data;
  }
}

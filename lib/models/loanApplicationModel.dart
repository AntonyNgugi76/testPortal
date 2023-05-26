class LoanApplicationModel {
  String? message;
  String? status;
  Data? data;

  LoanApplicationModel({this.message, this.status, this.data});

  LoanApplicationModel.fromJson(Map<String, dynamic> json) {
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
  String? howAreYou;
  String? welcomeHome;

  Survey({this.howAreYou, this.welcomeHome});

  Survey.fromJson(Map<String, dynamic> json) {
    howAreYou = json['how are you'];
    welcomeHome = json['welcome home'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['how are you'] = this.howAreYou;
    data['welcome home'] = this.welcomeHome;
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

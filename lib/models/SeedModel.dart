class SeedModel {
  String? message;
  String? status;
  List<Data>? data;

  SeedModel({this.message, this.status, this.data});

  SeedModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? seedId;
  String? name;
  int? period;
  String? status;

  Data({this.seedId, this.name, this.period, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    seedId = json['seedId'];
    name = json['name'];
    period = json['period'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seedId'] = this.seedId;
    data['name'] = this.name;
    data['period'] = this.period;
    data['status'] = this.status;
    return data;
  }
}

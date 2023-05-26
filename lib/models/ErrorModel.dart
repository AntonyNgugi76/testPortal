class ErrorModel {
  bool? error;
  String? status;
  int? timestamp;
  String? message;

  ErrorModel({this.error, this.status, this.timestamp, this.message});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    status = json['status'];
    timestamp = json['timestamp'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['status'] = this.status;
    data['timestamp'] = this.timestamp;
    data['message'] = this.message;
    return data;
  }
}

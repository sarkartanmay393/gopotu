// To parse this JSON data, do
//
//     final myEarningReportsSendModel = myEarningReportsSendModelFromJson(jsonString);

import 'dart:convert';

MyEarningReportsSendModel myEarningReportsSendModelFromJson(String str) => MyEarningReportsSendModel.fromJson(json.decode(str));

String myEarningReportsSendModelToJson(MyEarningReportsSendModel data) => json.encode(data.toJson());

class MyEarningReportsSendModel {
  MyEarningReportsSendModel({
    this.startDate,
    this.endDate,
  });

  String? startDate;
  String? endDate;

  factory MyEarningReportsSendModel.fromJson(Map<String, dynamic> json) => MyEarningReportsSendModel(
    startDate: json["start_date"],
    endDate: json["end_date"],
  );

  Map<String, dynamic> toJson() => {
    "start_date": startDate,
    "end_date": endDate,
  };
}

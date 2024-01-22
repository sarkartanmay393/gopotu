// To parse this JSON data, do
//
//     final stateListResponseModel = stateListResponseModelFromJson(jsonString);

import 'dart:convert';

StateListResponseModel stateListResponseModelFromJson(String str) => StateListResponseModel.fromJson(json.decode(str));

String stateListResponseModelToJson(StateListResponseModel data) => json.encode(data.toJson());

class StateListResponseModel {
  StateListResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  StateListData? data;

  factory StateListResponseModel.fromJson(Map<String, dynamic> json) => StateListResponseModel(
    status: json["status"],
    message: json["message"],
    data: StateListData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class StateListData {
  StateListData({
    this.states,
  });

  List<StateList>? states;

  factory StateListData.fromJson(Map<String, dynamic> json) => StateListData(
    states: List<StateList>.from(json["states"].map((x) => StateList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "states": List<dynamic>.from(states!.map((x) => x.toJson())),
  };
}

class StateList {
  StateList({
    this.id,
    this.stateName,
    this.tinNo,
    this.stateCode,
  });

  int? id;
  String? stateName;
  int? tinNo;
  String? stateCode;

  factory StateList.fromJson(Map<String, dynamic> json) => StateList(
    id: json["id"],
    stateName: json["state_name"],
    tinNo: json["tin_no"],
    stateCode: json["state_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "state_name": stateName,
    "tin_no": tinNo,
    "state_code": stateCode,
  };
}

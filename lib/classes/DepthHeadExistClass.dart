// To parse this JSON data, do
//
//     final depthHeadExistClass = depthHeadExistClassFromJson(jsonString);

import 'dart:convert';

DepthHeadExistClass depthHeadExistClassFromJson(String str) => DepthHeadExistClass.fromJson(json.decode(str));

String depthHeadExistClassToJson(DepthHeadExistClass data) => json.encode(data.toJson());

class DepthHeadExistClass {
    String status;
    String department;

    DepthHeadExistClass({
        this.status,
        this.department,
    });

    factory DepthHeadExistClass.fromJson(Map<String, dynamic> json) => DepthHeadExistClass(
        status: json["status"],
        department: json["department"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "department": department,
    };
}
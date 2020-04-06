// To parse this JSON data, do
//
//     final departmentClass = departmentClassFromJson(jsonString);

import 'dart:convert';

DepartmentClass departmentClassFromJson(String str) => DepartmentClass.fromJson(json.decode(str));

String departmentClassToJson(DepartmentClass data) => json.encode(data.toJson());

class DepartmentClass {
    List<Department> departments;
    String status;
    dynamic id;

    DepartmentClass({
        this.departments,
        this.status,
        this.id,
    });

    factory DepartmentClass.fromJson(Map<String, dynamic> json) => DepartmentClass(
        departments: List<Department>.from(json["departments"].map((x) => Department.fromJson(x))),
        status: json["status"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "departments": List<dynamic>.from(departments.map((x) => x.toJson())),
        "status": status,
        "id": id,
    };
}

class Department {
    int departmentId;
    String departmentName;

    Department({
        this.departmentId,
        this.departmentName,
    });

    factory Department.fromJson(Map<String, dynamic> json) => Department(
        departmentId: json["departmentID"],
        departmentName: json["departmentName"],
    );

    Map<String, dynamic> toJson() => {
        "departmentID": departmentId,
        "departmentName": departmentName,
    };
}

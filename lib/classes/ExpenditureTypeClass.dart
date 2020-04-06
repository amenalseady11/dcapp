// To parse this JSON data, do
//
//     final expenditureTypeClass = expenditureTypeClassFromJson(jsonString);

import 'dart:convert';

ExpenditureTypeClass expenditureTypeClassFromJson(String str) => ExpenditureTypeClass.fromJson(json.decode(str));

String expenditureTypeClassToJson(ExpenditureTypeClass data) => json.encode(data.toJson());

class ExpenditureTypeClass {
    List<ExpenditureType> expenditureTypes;
    String status;
    dynamic id;

    ExpenditureTypeClass({
        this.expenditureTypes,
        this.status,
        this.id,
    });

    factory ExpenditureTypeClass.fromJson(Map<String, dynamic> json) => ExpenditureTypeClass(
        expenditureTypes: List<ExpenditureType>.from(json["expenditureTypes"].map((x) => ExpenditureType.fromJson(x))),
        status: json["status"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "expenditureTypes": List<dynamic>.from(expenditureTypes.map((x) => x.toJson())),
        "status": status,
        "id": id,
    };
}

class ExpenditureType {
    int id;
    String expenditureName;

    ExpenditureType({
        this.id,
        this.expenditureName,
    });

    factory ExpenditureType.fromJson(Map<String, dynamic> json) => ExpenditureType(
        id: json["id"],
        expenditureName: json["expenditureName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "expenditureName": expenditureName,
    };
}

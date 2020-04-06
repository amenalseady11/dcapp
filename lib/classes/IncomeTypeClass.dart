// To parse this JSON data, do
//
//     final incomeTypeClass = incomeTypeClassFromJson(jsonString);

import 'dart:convert';

IncomeTypeClass incomeTypeClassFromJson(String str) => IncomeTypeClass.fromJson(json.decode(str));

String incomeTypeClassToJson(IncomeTypeClass data) => json.encode(data.toJson());

class IncomeTypeClass {
    List<IncomeType> incomeTypes;
    String status;
    dynamic id;

    IncomeTypeClass({
        this.incomeTypes,
        this.status,
        this.id,
    });

    factory IncomeTypeClass.fromJson(Map<String, dynamic> json) => IncomeTypeClass(
        incomeTypes: List<IncomeType>.from(json["incomeTypes"].map((x) => IncomeType.fromJson(x))),
        status: json["status"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "incomeTypes": List<dynamic>.from(incomeTypes.map((x) => x.toJson())),
        "status": status,
        "id": id,
    };
}

class IncomeType {
    int id;
    String incomeName;

    IncomeType({
        this.id,
        this.incomeName,
    });

    factory IncomeType.fromJson(Map<String, dynamic> json) => IncomeType(
        id: json["id"],
        incomeName: json["incomeName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "incomeName": incomeName,
    };
}

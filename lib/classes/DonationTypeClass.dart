// To parse this JSON data, do
//
//     final donationTypeClass = donationTypeClassFromJson(jsonString);

import 'dart:convert';

DonationTypeClass donationTypeClassFromJson(String str) => DonationTypeClass.fromJson(json.decode(str));

String donationTypeClassToJson(DonationTypeClass data) => json.encode(data.toJson());

class DonationTypeClass {
    List<DonationType> donationTypes;
    String status;
    dynamic id;

    DonationTypeClass({
        this.donationTypes,
        this.status,
        this.id,
    });

    factory DonationTypeClass.fromJson(Map<String, dynamic> json) => DonationTypeClass(
        donationTypes: List<DonationType>.from(json["donationTypes"].map((x) => DonationType.fromJson(x))),
        status: json["status"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "donationTypes": List<dynamic>.from(donationTypes.map((x) => x.toJson())),
        "status": status,
        "id": id,
    };
}

class DonationType {
    int id;
    String donationName;
    String note;
    String status;

    DonationType({
        this.id,
        this.donationName,
        this.note,
        this.status,
    });

    factory DonationType.fromJson(Map<String, dynamic> json) => DonationType(
        id: json["id"],
        donationName: json["donationName"],
        note: json["note"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "donationName": donationName,
        "note": note,
        "status": status,
    };
}

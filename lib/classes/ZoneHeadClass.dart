// To parse this JSON data, do
//
//     final zoneHeadClass = zoneHeadClassFromJson(jsonString);

import 'dart:convert';

ZoneHeadClass zoneHeadClassFromJson(String str) => ZoneHeadClass.fromJson(json.decode(str));

String zoneHeadClassToJson(ZoneHeadClass data) => json.encode(data.toJson());

class ZoneHeadClass {
    List<ZoneHead> zoneHeads;
    String status;
    dynamic id;

    ZoneHeadClass({
        this.zoneHeads,
        this.status,
        this.id,
    });

    factory ZoneHeadClass.fromJson(Map<String, dynamic> json) => ZoneHeadClass(
        zoneHeads: List<ZoneHead>.from(json["zoneHeads"].map((x) => ZoneHead.fromJson(x))),
        status: json["status"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "zoneHeads": List<dynamic>.from(zoneHeads.map((x) => x.toJson())),
        "status": status,
        "id": id,
    };
}

class ZoneHead {
    int id;
    Zone zone;
    MemberId memberId;
    DateTime datePosted;
    String status;

    ZoneHead({
        this.id,
        this.zone,
        this.memberId,
        this.datePosted,
        this.status,
    });

    factory ZoneHead.fromJson(Map<String, dynamic> json) => ZoneHead(
        id: json["id"],
        zone: Zone.fromJson(json["zone"]),
        memberId: MemberId.fromJson(json["memberID"]),
        datePosted: DateTime.parse(json["datePosted"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "zone": zone.toJson(),
        "memberID": memberId.toJson(),
        "datePosted": datePosted.toIso8601String(),
        "status": status,
    };
}

class MemberId {
    int memberId;
    String firstName;
    String middleName;
    String surName;
    String address;
    String city;
    String country;
    String state;
    String phoneNumber;
    String emailAddress;
    DateTime dob;
    String gender;
    String maritalStatus;
    DateTime anniversary;
    int invitedBy;
    String note;
    String status;
    bool guest;
    DateTime dateJoined;
    String pictureUrl;
    Branch branch;
    Zone zone;

    MemberId({
        this.memberId,
        this.firstName,
        this.middleName,
        this.surName,
        this.address,
        this.city,
        this.country,
        this.state,
        this.phoneNumber,
        this.emailAddress,
        this.dob,
        this.gender,
        this.maritalStatus,
        this.anniversary,
        this.invitedBy,
        this.note,
        this.status,
        this.guest,
        this.dateJoined,
        this.pictureUrl,
        this.branch,
        this.zone,
    });

    factory MemberId.fromJson(Map<String, dynamic> json) => MemberId(
        memberId: json["memberID"],
        firstName: json["firstName"],
        middleName: json["middleName"],
        surName: json["surName"],
        address: json["address"],
        city: json["city"],
        country: json["country"],
        state: json["state"],
        phoneNumber: json["phoneNumber"],
        emailAddress: json["emailAddress"],
        dob: DateTime.parse(json["dob"]),
        gender: json["gender"],
        maritalStatus: json["maritalStatus"],
        anniversary: DateTime.parse(json["anniversary"]),
        invitedBy: json["invitedBy"],
        note: json["note"],
        status: json["status"],
        guest: json["guest"],
        dateJoined: DateTime.parse(json["dateJoined"]),
        pictureUrl: json["pictureURL"],
        branch: Branch.fromJson(json["branch"]),
        zone: Zone.fromJson(json["zone"]),
    );

    Map<String, dynamic> toJson() => {
        "memberID": memberId,
        "firstName": firstName,
        "middleName": middleName,
        "surName": surName,
        "address": address,
        "city": city,
        "country": country,
        "state": state,
        "phoneNumber": phoneNumber,
        "emailAddress": emailAddress,
        "dob": dob.toIso8601String(),
        "gender": gender,
        "maritalStatus": maritalStatus,
        "anniversary": anniversary.toIso8601String(),
        "invitedBy": invitedBy,
        "note": note,
        "status": status,
        "guest": guest,
        "dateJoined": dateJoined.toIso8601String(),
        "pictureURL": pictureUrl,
        "branch": branch.toJson(),
        "zone": zone.toJson(),
    };
}

class Branch {
    dynamic branchId;
    dynamic branchName;
    dynamic state;
    dynamic city;
    dynamic country;
    int parentId;
    dynamic status;

    Branch({
        this.branchId,
        this.branchName,
        this.state,
        this.city,
        this.country,
        this.parentId,
        this.status,
    });

    factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        branchId: json["branchID"],
        branchName: json["branchName"],
        state: json["state"],
        city: json["city"],
        country: json["country"],
        parentId: json["parentID"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "branchID": branchId,
        "branchName": branchName,
        "state": state,
        "city": city,
        "country": country,
        "parentID": parentId,
        "status": status,
    };
}

class Zone {
    int zoneId;
    String zoneName;
    String adress;
    Branch branch;

    Zone({
        this.zoneId,
        this.zoneName,
        this.adress,
        this.branch,
    });

    factory Zone.fromJson(Map<String, dynamic> json) => Zone(
        zoneId: json["zoneID"] == null ? null : json["zoneID"],
        zoneName: json["zoneName"] == null ? null : json["zoneName"],
        adress: json["adress"] == null ? null : json["adress"],
        branch: Branch.fromJson(json["branch"]),
    );

    Map<String, dynamic> toJson() => {
        "zoneID": zoneId == null ? null : zoneId,
        "zoneName": zoneName == null ? null : zoneName,
        "adress": adress == null ? null : adress,
        "branch": branch.toJson(),
    };
}

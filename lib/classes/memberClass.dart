// To parse this JSON data, do
//
//     final memberClass = memberClassFromJson(jsonString);

import 'dart:convert';

MemberClass memberClassFromJson(String str) => MemberClass.fromJson(json.decode(str));

String memberClassToJson(MemberClass data) => json.encode(data.toJson());

class MemberClass {
    List<Member> members;
    String status;
    dynamic id;

    MemberClass({
        this.members,
        this.status,
        this.id,
    });

    factory MemberClass.fromJson(Map<String, dynamic> json) => MemberClass(
        members: List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
        status: json["status"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
        "status": status,
        "id": id,
    };
}

class Member {
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

    Member({
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

    factory Member.fromJson(Map<String, dynamic> json) => Member(
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
    int branchId;
    String branchName;
    String state;
    String city;
    String country;
    int parentId;
    String status;

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
        branchId: json["branchID"] == null ? null : json["branchID"],
        branchName: json["branchName"] == null ? null : json["branchName"],
        state: json["state"] == null ? null : json["state"],
        city: json["city"] == null ? null : json["city"],
        country: json["country"] == null ? null : json["country"],
        parentId: json["parentID"],
        status: json["status"] == null ? null : json["status"],
    );

    Map<String, dynamic> toJson() => {
        "branchID": branchId == null ? null : branchId,
        "branchName": branchName == null ? null : branchName,
        "state": state == null ? null : state,
        "city": city == null ? null : city,
        "country": country == null ? null : country,
        "parentID": parentId,
        "status": status == null ? null : status,
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
        zoneId: json["zoneID"],
        zoneName: json["zoneName"],
        adress: json["adress"],
        branch: Branch.fromJson(json["branch"]),
    );

    Map<String, dynamic> toJson() => {
        "zoneID": zoneId,
        "zoneName": zoneName,
        "adress": adress,
        "branch": branch.toJson(),
    };
}

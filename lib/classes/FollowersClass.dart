// To parse this JSON data, do
//
//     final followersClass = followersClassFromJson(jsonString);

import 'dart:convert';

FollowersClass followersClassFromJson(String str) => FollowersClass.fromJson(json.decode(str));

String followersClassToJson(FollowersClass data) => json.encode(data.toJson());

class FollowersClass {
    List<Myfollower> myfollowers;
    String status;
    dynamic id;

    FollowersClass({
        this.myfollowers,
        this.status,
        this.id,
    });

    factory FollowersClass.fromJson(Map<String, dynamic> json) => FollowersClass(
        myfollowers: List<Myfollower>.from(json["myfollowers"].map((x) => Myfollower.fromJson(x))),
        status: json["status"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "myfollowers": List<dynamic>.from(myfollowers.map((x) => x.toJson())),
        "status": status,
        "id": id,
    };
}

class Myfollower {
    int id;
    String firstName;
    String lastName;
    dynamic middleName;
    String phone;
    String email;
    DateTime dateJoined;
    DateTime birthDate;
    String prayerRequest;
    Parent parent;
    String status;

    Myfollower({
        this.id,
        this.firstName,
        this.lastName,
        this.middleName,
        this.phone,
        this.email,
        this.dateJoined,
        this.birthDate,
        this.prayerRequest,
        this.parent,
        this.status,
    });

    factory Myfollower.fromJson(Map<String, dynamic> json) => Myfollower(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        middleName: json["middleName"],
        phone: json["phone"],
        email: json["email"],
        dateJoined: DateTime.parse(json["dateJoined"]),
        birthDate: DateTime.parse(json["birthDate"]),
        prayerRequest: json["prayerRequest"],
        parent: Parent.fromJson(json["parent"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "middleName": middleName,
        "phone": phone,
        "email": email,
        "dateJoined": dateJoined.toIso8601String(),
        "birthDate": birthDate.toIso8601String(),
        "prayerRequest": prayerRequest,
        "parent": parent.toJson(),
        "status": status,
    };
}

class Parent {
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
    dynamic status;
    bool guest;
    DateTime dateJoined;
    String pictureUrl;
    Branch branch;
    Zone zone;

    Parent({
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

    factory Parent.fromJson(Map<String, dynamic> json) => Parent(
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
    dynamic zoneId;
    dynamic zoneName;
    dynamic adress;
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

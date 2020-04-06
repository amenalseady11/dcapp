// To parse this JSON data, do
//
//     final userClass = userClassFromJson(jsonString);

import 'dart:convert';

UserClass userClassFromJson(String str) => UserClass.fromJson(json.decode(str));

String userClassToJson(UserClass data) => json.encode(data.toJson());

class UserClass {
    List<User> users;
    String status;
    dynamic id;

    UserClass({
        this.users,
        this.status,
        this.id,
    });

    factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
        status: json["status"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "status": status,
        "id": id,
    };
}

class User {
    int id;
    String userName;
    String passWord;
    String status;
    DateTime dateCreated;
    String position;
    Member member;

    User({
        this.id,
        this.userName,
        this.passWord,
        this.status,
        this.dateCreated,
        this.position,
        this.member,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        userName: json["userName"],
        passWord: json["passWord"],
        status: json["status"],
        dateCreated: DateTime.parse(json["dateCreated"]),
        position: json["position"],
        member: Member.fromJson(json["member"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "passWord": passWord,
        "status": status,
        "dateCreated": dateCreated.toIso8601String(),
        "position": position,
        "member": member.toJson(),
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
        status: json["status"] == null ? null : json["status"],
        guest: json["guest"],
        dateJoined: DateTime.parse(json["dateJoined"]),
        pictureUrl: json["pictureURL"] == null ? null : json["pictureURL"],
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
        "status": status == null ? null : status,
        "guest": guest,
        "dateJoined": dateJoined.toIso8601String(),
        "pictureURL": pictureUrl == null ? null : pictureUrl,
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

// To parse this JSON data, do
//
//     final memberRoleClass = memberRoleClassFromJson(jsonString);

import 'dart:convert';

MemberRoleClass memberRoleClassFromJson(String str) => MemberRoleClass.fromJson(json.decode(str));

String memberRoleClassToJson(MemberRoleClass data) => json.encode(data.toJson());

class MemberRoleClass {
    List<Role> roles;
    dynamic actions;
    String status;
    dynamic id;

    MemberRoleClass({
        this.roles,
        this.actions,
        this.status,
        this.id,
    });

    factory MemberRoleClass.fromJson(Map<String, dynamic> json) => MemberRoleClass(
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
        actions: json["actions"],
        status: json["status"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
        "actions": actions,
        "status": status,
        "id": id,
    };
}

class Role {
    dynamic id;
    dynamic action;
    Members members;
    Branch branch;

    Role({
        this.id,
        this.action,
        this.members,
        this.branch,
    });

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        action: json["action"],
        members: Members.fromJson(json["members"]),
        branch: Branch.fromJson(json["branch"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "action": action,
        "members": members.toJson(),
        "branch": branch.toJson(),
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

class Members {
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

    Members({
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

    factory Members.fromJson(Map<String, dynamic> json) => Members(
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

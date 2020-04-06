// To parse this JSON data, do
//
//     final devotionalCommentClass = devotionalCommentClassFromJson(jsonString);

import 'dart:convert';

DevotionalCommentClass devotionalCommentClassFromJson(String str) => DevotionalCommentClass.fromJson(json.decode(str));

String devotionalCommentClassToJson(DevotionalCommentClass data) => json.encode(data.toJson());

class DevotionalCommentClass {
    dynamic devotionals;
    List<DevotionalComment> devotionalComments;
    String status;
    dynamic id;

    DevotionalCommentClass({
        this.devotionals,
        this.devotionalComments,
        this.status,
        this.id,
    });

    factory DevotionalCommentClass.fromJson(Map<String, dynamic> json) => DevotionalCommentClass(
        devotionals: json["devotionals"],
        devotionalComments: List<DevotionalComment>.from(json["devotionalComments"].map((x) => DevotionalComment.fromJson(x))),
        status: json["status"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "devotionals": devotionals,
        "devotionalComments": List<dynamic>.from(devotionalComments.map((x) => x.toJson())),
        "status": status,
        "id": id,
    };
}

class DevotionalComment {
    int id;
    DateTime dateCommented;
    String comment;
    Member member;
    Devotional devotional;
    int likeCount;
    String status;

    DevotionalComment({
        this.id,
        this.dateCommented,
        this.comment,
        this.member,
        this.devotional,
        this.likeCount,
        this.status,
    });

    factory DevotionalComment.fromJson(Map<String, dynamic> json) => DevotionalComment(
        id: json["id"],
        dateCommented: DateTime.parse(json["dateCommented"]),
        comment: json["comment"],
        member: Member.fromJson(json["member"]),
        devotional: Devotional.fromJson(json["devotional"]),
        likeCount: json["likeCount"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "dateCommented": dateCommented.toIso8601String(),
        "comment": comment,
        "member": member.toJson(),
        "devotional": devotional.toJson(),
        "likeCount": likeCount,
        "status": status,
    };
}

class Devotional {
    dynamic id;
    dynamic title;
    dynamic devotionaltext;
    DateTime datePublished;
    dynamic status;
    int likeCount;
    dynamic rawtext;

    Devotional({
        this.id,
        this.title,
        this.devotionaltext,
        this.datePublished,
        this.status,
        this.likeCount,
        this.rawtext,
    });

    factory Devotional.fromJson(Map<String, dynamic> json) => Devotional(
        id: json["id"],
        title: json["title"],
        devotionaltext: json["devotionaltext"],
        datePublished: DateTime.parse(json["datePublished"]),
        status: json["status"],
        likeCount: json["likeCount"],
        rawtext: json["rawtext"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "devotionaltext": devotionaltext,
        "datePublished": datePublished.toIso8601String(),
        "status": status,
        "likeCount": likeCount,
        "rawtext": rawtext,
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
    dynamic status;
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

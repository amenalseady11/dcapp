// To parse this JSON data, do
//
//     final smsTemplateClass = smsTemplateClassFromJson(jsonString);

import 'dart:convert';

SmsTemplateClass smsTemplateClassFromJson(String str) => SmsTemplateClass.fromJson(json.decode(str));

String smsTemplateClassToJson(SmsTemplateClass data) => json.encode(data.toJson());

class SmsTemplateClass {
    List<SMsTemplate> sMsTemplates;
    String status;
    dynamic id;

    SmsTemplateClass({
        this.sMsTemplates,
        this.status,
        this.id,
    });

    factory SmsTemplateClass.fromJson(Map<String, dynamic> json) => SmsTemplateClass(
        sMsTemplates: List<SMsTemplate>.from(json["sMSTemplates"].map((x) => SMsTemplate.fromJson(x))),
        status: json["status"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "sMSTemplates": List<dynamic>.from(sMsTemplates.map((x) => x.toJson())),
        "status": status,
        "id": id,
    };
}

class SMsTemplate {
    int id;
    String smsTitle;
    String sms;
    String status;
    Branch branch;
    Zone zone;
    Member member;

    SMsTemplate({
        this.id,
        this.smsTitle,
        this.sms,
        this.status,
        this.branch,
        this.zone,
        this.member,
    });

    factory SMsTemplate.fromJson(Map<String, dynamic> json) => SMsTemplate(
        id: json["id"],
        smsTitle: json["smsTitle"],
        sms: json["sms"],
        status: json["status"],
        branch: Branch.fromJson(json["branch"]),
        zone: Zone.fromJson(json["zone"]),
        member: Member.fromJson(json["member"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "smsTitle": smsTitle,
        "sms": sms,
        "status": status,
        "branch": branch.toJson(),
        "zone": zone.toJson(),
        "member": member.toJson(),
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

class Member {
    int memberId;
    dynamic firstName;
    dynamic middleName;
    dynamic surName;
    dynamic address;
    dynamic city;
    dynamic country;
    dynamic state;
    dynamic phoneNumber;
    dynamic emailAddress;
    DateTime dob;
    dynamic gender;
    dynamic maritalStatus;
    DateTime anniversary;
    int invitedBy;
    dynamic note;
    dynamic status;
    bool guest;
    DateTime dateJoined;
    dynamic pictureUrl;
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

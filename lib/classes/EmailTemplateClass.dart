// To parse this JSON data, do
//
//     final emailTemplateClass = emailTemplateClassFromJson(jsonString);

import 'dart:convert';

EmailTemplateClass emailTemplateClassFromJson(String str) => EmailTemplateClass.fromJson(json.decode(str));

String emailTemplateClassToJson(EmailTemplateClass data) => json.encode(data.toJson());

class EmailTemplateClass {
    List<EmailTemplate> emailTemplates;
    String status;
    dynamic id;

    EmailTemplateClass({
        this.emailTemplates,
        this.status,
        this.id,
    });

    factory EmailTemplateClass.fromJson(Map<String, dynamic> json) => EmailTemplateClass(
        emailTemplates: List<EmailTemplate>.from(json["emailTemplates"].map((x) => EmailTemplate.fromJson(x))),
        status: json["status"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "emailTemplates": List<dynamic>.from(emailTemplates.map((x) => x.toJson())),
        "status": status,
        "id": id,
    };
}

class EmailTemplate {
    int id;
    String emailTitle;
    String emailBody;
    Branch branch;
    Zone zone;
    String status;

    EmailTemplate({
        this.id,
        this.emailTitle,
        this.emailBody,
        this.branch,
        this.zone,
        this.status,
    });

    factory EmailTemplate.fromJson(Map<String, dynamic> json) => EmailTemplate(
        id: json["id"],
        emailTitle: json["emailTitle"],
        emailBody: json["emailBody"],
        branch: Branch.fromJson(json["branch"]),
        zone: Zone.fromJson(json["zone"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "emailTitle": emailTitle,
        "emailBody": emailBody,
        "branch": branch.toJson(),
        "zone": zone.toJson(),
        "status": status,
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

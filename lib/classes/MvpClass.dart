// To parse this JSON data, do
//
//     final mvpClass = mvpClassFromJson(jsonString);

import 'dart:convert';

MvpClass mvpClassFromJson(String str) => MvpClass.fromJson(json.decode(str));

String mvpClassToJson(MvpClass data) => json.encode(data.toJson());

class MvpClass {
    List<MvP> mvPs;
    String status;
    dynamic id;

    MvpClass({
        this.mvPs,
        this.status,
        this.id,
    });

    factory MvpClass.fromJson(Map<String, dynamic> json) => MvpClass(
        mvPs: List<MvP>.from(json["mvPs"].map((x) => MvP.fromJson(x))),
        status: json["status"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "mvPs": List<dynamic>.from(mvPs.map((x) => x.toJson())),
        "status": status,
        "id": id,
    };
}

class MvP {
    int memberId;
    String memberName;
    String phoneNumber;
    String branch;
    String zone;
    String email;
    DateTime dateJoined;
    int memberSince;

    MvP({
        this.memberId,
        this.memberName,
        this.phoneNumber,
        this.branch,
        this.zone,
        this.email,
        this.dateJoined,
        this.memberSince,
    });

    factory MvP.fromJson(Map<String, dynamic> json) => MvP(
        memberId: json["memberID"],
        memberName: json["memberName"],
        phoneNumber: json["phoneNumber"],
        branch: json["branch"] == null ? null : json["branch"],
        zone: json["zone"] == null ? null : json["zone"],
        email: json["email"],
        dateJoined: DateTime.parse(json["dateJoined"]),
        memberSince: json["memberSince"],
    );

    Map<String, dynamic> toJson() => {
        "memberID": memberId,
        "memberName": memberName,
        "phoneNumber": phoneNumber,
        "branch":  branch == null ? null : branch,
        "zone": zone == null ? null : zone,
        "email": email == null ? null : email,
        "dateJoined": dateJoined.toIso8601String(),
        "memberSince": memberSince,
    };
}

enum Branch { HQ_LAGOS }

final branchValues = EnumValues({
    "HQ Lagos": Branch.HQ_LAGOS
});

enum Email { SUPERBRAINS2005_YAHOO_COM, PSALMTRUMPET_GMAIL_COM, GRACE_GMAIL_COM }

final emailValues = EnumValues({
    "grace@gmail.com ": Email.GRACE_GMAIL_COM,
    "psalmtrumpet@gmail.com ": Email.PSALMTRUMPET_GMAIL_COM,
    "superbrains2005@yahoo.com": Email.SUPERBRAINS2005_YAHOO_COM
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}

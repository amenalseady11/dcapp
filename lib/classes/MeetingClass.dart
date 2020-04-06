// To parse this JSON data, do
//
//     final meetingClass = meetingClassFromJson(jsonString);

import 'dart:convert';

MeetingClass meetingClassFromJson(String str) => MeetingClass.fromJson(json.decode(str));

String meetingClassToJson(MeetingClass data) => json.encode(data.toJson());

class MeetingClass {
    List<Meeting> meetings;
    String status;
    dynamic id;

    MeetingClass({
        this.meetings,
        this.status,
        this.id,
    });

    factory MeetingClass.fromJson(Map<String, dynamic> json) => MeetingClass(
        meetings: List<Meeting>.from(json["meetings"].map((x) => Meeting.fromJson(x))),
        status: json["status"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "meetings": List<dynamic>.from(meetings.map((x) => x.toJson())),
        "status": status,
        "id": id,
    };
}

class Meeting {
    int id;
    DateTime startTime;
    String meetingTitle;
    String status;
    Branch branch;

    Meeting({
        this.id,
        this.startTime,
        this.meetingTitle,
        this.status,
        this.branch,
    });

    factory Meeting.fromJson(Map<String, dynamic> json) => Meeting(
        id: json["id"],
        startTime: DateTime.parse(json["startTime"]),
        meetingTitle: json["meetingTitle"],
        status: json["status"],
        branch: Branch.fromJson(json["branch"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "startTime": startTime.toIso8601String(),
        "meetingTitle": meetingTitle,
        "status": status,
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

// To parse this JSON data, do
//
//     final profileClass = profileClassFromJson(jsonString);

import 'dart:convert';

ProfileClass profileClassFromJson(String str) => ProfileClass.fromJson(json.decode(str));

String profileClassToJson(ProfileClass data) => json.encode(data.toJson());

class ProfileClass {
    Member member;
    dynamic role;
    dynamic actions;
    List<MembersTraining> membersTrainings;
    List<MembersDept> membersDept;
    List<DeptDirectory> deptDirectory;
    List<DeptTable> deptTable;
    List<TrainingTable> trainingTables;
    List<Training> allTraining;
    String trainingindex;
    String zoneName;
    String zoneHeadName;
    String zoneHeadEmail;
    String zoneHeadPhone;
    String position;
    String status;

    ProfileClass({
        this.member,
        this.role,
        this.actions,
        this.membersTrainings,
        this.membersDept,
        this.deptDirectory,
        this.deptTable,
        this.trainingTables,
        this.allTraining,
        this.trainingindex,
        this.zoneName,
        this.zoneHeadName,
        this.zoneHeadEmail,
        this.zoneHeadPhone,
        this.position,
        this.status,
    });

    factory ProfileClass.fromJson(Map<String, dynamic> json) => ProfileClass(
        member: Member.fromJson(json["member"]),
        role: json["role"],
        actions: json["actions"],
        membersTrainings: List<MembersTraining>.from(json["membersTrainings"].map((x) => MembersTraining.fromJson(x))),
        membersDept: List<MembersDept>.from(json["membersDept"].map((x) => MembersDept.fromJson(x))),
        deptDirectory: List<DeptDirectory>.from(json["deptDirectory"].map((x) => DeptDirectory.fromJson(x))),
        deptTable: List<DeptTable>.from(json["deptTable"].map((x) => DeptTable.fromJson(x))),
        trainingTables: List<TrainingTable>.from(json["trainingTables"].map((x) => TrainingTable.fromJson(x))),
        allTraining: List<Training>.from(json["allTraining"].map((x) => Training.fromJson(x))),
        trainingindex: json["trainingindex"],
        zoneName: json["zoneName"],
        zoneHeadName: json["zoneHeadName"],
        zoneHeadEmail: json["zoneHeadEmail"],
        zoneHeadPhone: json["zoneHeadPhone"],
        position: json["position"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "member": member.toJson(),
        "role": role,
        "actions": actions,
        "membersTrainings": List<dynamic>.from(membersTrainings.map((x) => x.toJson())),
        "membersDept": List<dynamic>.from(membersDept.map((x) => x.toJson())),
        "deptDirectory": List<dynamic>.from(deptDirectory.map((x) => x.toJson())),
        "deptTable": List<dynamic>.from(deptTable.map((x) => x.toJson())),
        "trainingTables": List<dynamic>.from(trainingTables.map((x) => x.toJson())),
        "allTraining": List<dynamic>.from(allTraining.map((x) => x.toJson())),
        "trainingindex": trainingindex,
        "zoneName": zoneName,
        "zoneHeadName": zoneHeadName,
        "zoneHeadEmail": zoneHeadEmail,
        "zoneHeadPhone": zoneHeadPhone,
        "position": position,
        "status": status,
    };
}

class Training {
    int trainingId;
    String trainingName;

    Training({
        this.trainingId,
        this.trainingName,
    });

    factory Training.fromJson(Map<String, dynamic> json) => Training(
        trainingId: json["trainingID"],
        trainingName: json["trainingName"],
    );

    Map<String, dynamic> toJson() => {
        "trainingID": trainingId,
        "trainingName": trainingName,
    };
}

class DeptDirectory {
    String name;
    String phone;
    String email;
    String department;
    String pictureUrl;

    DeptDirectory({
        this.name,
        this.phone,
        this.email,
        this.department,
        this.pictureUrl,
    });

    factory DeptDirectory.fromJson(Map<String, dynamic> json) => DeptDirectory(
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        department: json["department"],
        pictureUrl: json["pictureURL"] == null ? null : json["pictureURL"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "department": department,
        "pictureURL": pictureUrl == null ? null : pictureUrl,
    };
}

class DeptTable {
    String department;
    String departmentHead;
    String departmentHeadContact;

    DeptTable({
        this.department,
        this.departmentHead,
        this.departmentHeadContact,
    });

    factory DeptTable.fromJson(Map<String, dynamic> json) => DeptTable(
        department: json["department"],
        departmentHead: json["departmentHead"],
        departmentHeadContact: json["departmentHeadContact"],
    );

    Map<String, dynamic> toJson() => {
        "department": department,
        "departmentHead": departmentHead,
        "departmentHeadContact": departmentHeadContact,
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

class MembersDept {
    int id;
    DateTime dateJoined;
    dynamic status;
    Member member;
    Department department;
    Branch branch;

    MembersDept({
        this.id,
        this.dateJoined,
        this.status,
        this.member,
        this.department,
        this.branch,
    });

    factory MembersDept.fromJson(Map<String, dynamic> json) => MembersDept(
        id: json["id"],
        dateJoined: DateTime.parse(json["dateJoined"]),
        status: json["status"],
        member: Member.fromJson(json["member"]),
        department: Department.fromJson(json["department"]),
        branch: Branch.fromJson(json["branch"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "dateJoined": dateJoined.toIso8601String(),
        "status": status,
        "member": member.toJson(),
        "department": department.toJson(),
        "branch": branch.toJson(),
    };
}

class Department {
    int departmentId;
    String departmentName;

    Department({
        this.departmentId,
        this.departmentName,
    });

    factory Department.fromJson(Map<String, dynamic> json) => Department(
        departmentId: json["departmentID"],
        departmentName: json["departmentName"],
    );

    Map<String, dynamic> toJson() => {
        "departmentID": departmentId,
        "departmentName": departmentName,
    };
}

class MembersTraining {
    int id;
    DateTime dateJoined;
    DateTime dateEnded;
    Member member;
    Training training;
    String status;
    dynamic notes;

    MembersTraining({
        this.id,
        this.dateJoined,
        this.dateEnded,
        this.member,
        this.training,
        this.status,
        this.notes,
    });

    factory MembersTraining.fromJson(Map<String, dynamic> json) => MembersTraining(
        id: json["id"],
        dateJoined: DateTime.parse(json["dateJoined"]),
        dateEnded: DateTime.parse(json["dateEnded"]),
        member: Member.fromJson(json["member"]),
        training: Training.fromJson(json["training"]),
        status: json["status"],
        notes: json["notes"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "dateJoined": dateJoined.toIso8601String(),
        "dateEnded": dateEnded.toIso8601String(),
        "member": member.toJson(),
        "training": training.toJson(),
        "status": status,
        "notes": notes,
    };
}

class TrainingTable {
    String training;
    String status;
    DateTime dateStarted;
    DateTime dateEnded;

    TrainingTable({
        this.training,
        this.status,
        this.dateStarted,
        this.dateEnded,
    });

    factory TrainingTable.fromJson(Map<String, dynamic> json) => TrainingTable(
        training: json["training"],
        status: json["status"],
        dateStarted: json["dateStarted"] == null ? null : DateTime.parse(json["dateStarted"]),
        dateEnded: json["dateEnded"] == null ? null : DateTime.parse(json["dateEnded"]),
    );

    Map<String, dynamic> toJson() => {
        "training": training,
        "status": status,
        "dateStarted": dateStarted == null ? null : dateStarted.toIso8601String(),
        "dateEnded": dateEnded == null ? null : dateEnded.toIso8601String(),
    };
}

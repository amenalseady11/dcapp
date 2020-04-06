// To parse this JSON data, do
//
//     final discipleshipStatusClass = discipleshipStatusClassFromJson(jsonString);

import 'dart:convert';

DiscipleshipStatusClass discipleshipStatusClassFromJson(String str) => DiscipleshipStatusClass.fromJson(json.decode(str));

String discipleshipStatusClassToJson(DiscipleshipStatusClass data) => json.encode(data.toJson());

class DiscipleshipStatusClass {
    dynamic discipleships;
    String status;
    dynamic id;
    List<Discipleshipstatus> discipleshipstatus;
    List<DiscipleshipStatusClassTraining> trainings;

    DiscipleshipStatusClass({
        this.discipleships,
        this.status,
        this.id,
        this.discipleshipstatus,
        this.trainings,
    });

    factory DiscipleshipStatusClass.fromJson(Map<String, dynamic> json) => DiscipleshipStatusClass(
        discipleships: json["discipleships"],
        status: json["status"],
        id: json["id"],
        discipleshipstatus: List<Discipleshipstatus>.from(json["discipleshipstatus"].map((x) => Discipleshipstatus.fromJson(x))),
        trainings: List<DiscipleshipStatusClassTraining>.from(json["trainings"].map((x) => DiscipleshipStatusClassTraining.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "discipleships": discipleships,
        "status": status,
        "id": id,
        "discipleshipstatus": List<dynamic>.from(discipleshipstatus.map((x) => x.toJson())),
        "trainings": List<dynamic>.from(trainings.map((x) => x.toJson())),
    };
}

class Discipleshipstatus {
    int memberId;
    String memberName;
    String branch;
    List<DiscipleshipstatusTraining> training;

    Discipleshipstatus({
        this.memberId,
        this.memberName,
        this.branch,
        this.training,
    });

    factory Discipleshipstatus.fromJson(Map<String, dynamic> json) => Discipleshipstatus(
        memberId: json["memberID"],
        memberName: json["memberName"],
        branch: json["branch"] == null ? null : json["branch"],
        training: List<DiscipleshipstatusTraining>.from(json["training"].map((x) => DiscipleshipstatusTraining.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "memberID": memberId,
        "memberName": memberName,
        "branch":  branch == null ? null : branch,
        "training": List<dynamic>.from(training.map((x) => x.toJson())),
    };
}

enum Branch { HQ_LAGOS }

final branchValues = EnumValues({
    "HQ Lagos": Branch.HQ_LAGOS
});

class DiscipleshipstatusTraining {
    String status;
    int trainingId;

    DiscipleshipstatusTraining({
        this.status,
        this.trainingId,
    });

    factory DiscipleshipstatusTraining.fromJson(Map<String, dynamic> json) => DiscipleshipstatusTraining(
        status: json["status"],
        trainingId: json["trainingID"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "trainingID": trainingId,
    };
}

enum Status { NOT_DONE, DONE }

final statusValues = EnumValues({
    "Done": Status.DONE,
    "Not Done": Status.NOT_DONE
});

class DiscipleshipStatusClassTraining {
    int trainingId;
    String trainingName;

    DiscipleshipStatusClassTraining({
        this.trainingId,
        this.trainingName,
    });

    factory DiscipleshipStatusClassTraining.fromJson(Map<String, dynamic> json) => DiscipleshipStatusClassTraining(
        trainingId: json["trainingID"],
        trainingName: json["trainingName"],
    );

    Map<String, dynamic> toJson() => {
        "trainingID": trainingId,
        "trainingName": trainingName,
    };
}

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

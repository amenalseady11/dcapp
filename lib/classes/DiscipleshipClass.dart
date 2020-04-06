// To parse this JSON data, do
//
//     final discipleshipClass = discipleshipClassFromJson(jsonString);

import 'dart:convert';

DiscipleshipClass discipleshipClassFromJson(String str) => DiscipleshipClass.fromJson(json.decode(str));

String discipleshipClassToJson(DiscipleshipClass data) => json.encode(data.toJson());

class DiscipleshipClass {
    List<Discipleship> discipleships;
    String status;
    dynamic id;

    DiscipleshipClass({
        this.discipleships,
        this.status,
        this.id,
    });

    factory DiscipleshipClass.fromJson(Map<String, dynamic> json) => DiscipleshipClass(
        discipleships: List<Discipleship>.from(json["discipleships"].map((x) => Discipleship.fromJson(x))),
        status: json["status"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "discipleships": List<dynamic>.from(discipleships.map((x) => x.toJson())),
        "status": status,
        "id": id,
    };
}

class Discipleship {
    int trainingId;
    String trainingName;

    Discipleship({
        this.trainingId,
        this.trainingName,
    });

    factory Discipleship.fromJson(Map<String, dynamic> json) => Discipleship(
        trainingId: json["trainingID"],
        trainingName: json["trainingName"],
    );

    Map<String, dynamic> toJson() => {
        "trainingID": trainingId,
        "trainingName": trainingName,
    };
}

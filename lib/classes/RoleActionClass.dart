// To parse this JSON data, do
//
//     final roleActionClass = roleActionClassFromJson(jsonString);

import 'dart:convert';

RoleActionClass roleActionClassFromJson(String str) => RoleActionClass.fromJson(json.decode(str));

String roleActionClassToJson(RoleActionClass data) => json.encode(data.toJson());

class RoleActionClass {
    dynamic roles;
    List<Action> actions;
    String status;
    dynamic id;

    RoleActionClass({
        this.roles,
        this.actions,
        this.status,
        this.id,
    });

    factory RoleActionClass.fromJson(Map<String, dynamic> json) => RoleActionClass(
        roles: json["roles"],
        actions: List<Action>.from(json["actions"].map((x) => Action.fromJson(x))),
        status: json["status"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "roles": roles,
        "actions": List<dynamic>.from(actions.map((x) => x.toJson())),
        "status": status,
        "id": id,
    };
}

class Action {
    int id;
    String action;

    Action({
        this.id,
        this.action,
    });

    factory Action.fromJson(Map<String, dynamic> json) => Action(
        id: json["id"],
        action: json["action"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "action": action,
    };
}

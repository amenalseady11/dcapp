// To parse this JSON data, do
//
//     final registrationresponseClass = registrationresponseClassFromJson(jsonString);

import 'dart:convert';

RegistrationresponseClass registrationresponseClassFromJson(String str) => RegistrationresponseClass.fromJson(json.decode(str));

String registrationresponseClassToJson(RegistrationresponseClass data) => json.encode(data.toJson());

class RegistrationresponseClass {
    dynamic members;
    String status;
    int id;
    RegistrationResponse registrationResponse;

    RegistrationresponseClass({
        this.members,
        this.status,
        this.id,
        this.registrationResponse,
    });

    factory RegistrationresponseClass.fromJson(Map<String, dynamic> json) => RegistrationresponseClass(
        members: json["members"],
        status: json["status"],
        id: json["id"],
        registrationResponse: RegistrationResponse.fromJson(json["registrationResponse"]),
    );

    Map<String, dynamic> toJson() => {
        "members": members,
        "status": status,
        "id": id,
        "registrationResponse": registrationResponse.toJson(),
    };
}

class RegistrationResponse {
    String email;
    String password;

    RegistrationResponse({
        this.email,
        this.password,
    });

    factory RegistrationResponse.fromJson(Map<String, dynamic> json) => RegistrationResponse(
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
    };
}

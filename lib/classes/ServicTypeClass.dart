// To parse this JSON data, do
//
//     final serviceTypeClass = serviceTypeClassFromJson(jsonString);

import 'dart:convert';

ServiceTypeClass serviceTypeClassFromJson(String str) => ServiceTypeClass.fromJson(json.decode(str));

String serviceTypeClassToJson(ServiceTypeClass data) => json.encode(data.toJson());

class ServiceTypeClass {
    List<ServiceType> serviceTypes;
    String status;
    dynamic id;

    ServiceTypeClass({
        this.serviceTypes,
        this.status,
        this.id,
    });

    factory ServiceTypeClass.fromJson(Map<String, dynamic> json) => ServiceTypeClass(
        serviceTypes: List<ServiceType>.from(json["serviceTypes"].map((x) => ServiceType.fromJson(x))),
        status: json["status"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "serviceTypes": List<dynamic>.from(serviceTypes.map((x) => x.toJson())),
        "status": status,
        "id": id,
    };
}

class ServiceType {
    int serviceId;
    String serviceName;

    ServiceType({
        this.serviceId,
        this.serviceName,
    });

    factory ServiceType.fromJson(Map<String, dynamic> json) => ServiceType(
        serviceId: json["serviceID"],
        serviceName: json["serviceName"],
    );

    Map<String, dynamic> toJson() => {
        "serviceID": serviceId,
        "serviceName": serviceName,
    };
}

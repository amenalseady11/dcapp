// To parse this JSON data, do
//
//     final zoneClass = zoneClassFromJson(jsonString);

import 'dart:convert';

List<ZoneClass> zoneClassFromJson(String str) => List<ZoneClass>.from(json.decode(str).map((x) => ZoneClass.fromJson(x)));

String zoneClassToJson(List<ZoneClass> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ZoneClass {
    int zoneId;
    String zoneName;
    String adress;
    Branch branch;

    ZoneClass({
        this.zoneId,
        this.zoneName,
        this.adress,
        this.branch,
    });

    factory ZoneClass.fromJson(Map<String, dynamic> json) => ZoneClass(
        zoneId: json["zoneID"],
        zoneName: json["zoneName"] == null ? null : json["zoneName"],
        adress: json["adress"] == null ? null : json["adress"],
        branch: Branch.fromJson(json["branch"]),
    );

    Map<String, dynamic> toJson() => {
        "zoneID": zoneId,
        "zoneName": zoneName == null ? null : zoneName,
        "adress": adress == null ? null : adress,
        "branch": branch.toJson(),
    };
}

class Branch {
    int branchId;
    String branchName;
    City state;
    City city;
    Country country;
    int parentId;
    Status status;

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
        branchName: json["branchName"] == null ? null : json["branchName"],
        state: json["state"] == null ? null : cityValues.map[json["state"]],
        city: json["city"] == null ? null : cityValues.map[json["city"]],
        country: json["country"] == null ? null : countryValues.map[json["country"]],
        parentId: json["parentID"],
        status: json["status"] == null ? null : statusValues.map[json["status"]],
    );

    Map<String, dynamic> toJson() => {
        "branchID": branchId,
        "branchName": branchName == null ? null : branchName,
        "state": state == null ? null : cityValues.reverse[state],
        "city": city == null ? null : cityValues.reverse[city],
        "country": country == null ? null : countryValues.reverse[country],
        "parentID": parentId,
        "status": status == null ? null : statusValues.reverse[status],
    };
}

enum City { LAGOS, CITY_LAGOS, PURPLE_LAGOS }

final cityValues = EnumValues({
    "LAGOS ": City.CITY_LAGOS,
    "Lagos": City.LAGOS,
    "LAGOS": City.PURPLE_LAGOS
});

enum Country { NIGERIA, COUNTRY_NIGERIA, PURPLE_NIGERIA }

final countryValues = EnumValues({
    "NIGERIA ": Country.COUNTRY_NIGERIA,
    "Nigeria": Country.NIGERIA,
    "NIGERIA": Country.PURPLE_NIGERIA
});

enum Status { ACTIVE }

final statusValues = EnumValues({
    "Active": Status.ACTIVE
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

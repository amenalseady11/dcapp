// To parse this JSON data, do
//
//     final devotionalClass = devotionalClassFromJson(jsonString);

import 'dart:convert';

DevotionalClass devotionalClassFromJson(String str) => DevotionalClass.fromJson(json.decode(str));

String devotionalClassToJson(DevotionalClass data) => json.encode(data.toJson());

class DevotionalClass {
    List<Devotional> devotionals;
    String status;
    dynamic id;

    DevotionalClass({
        this.devotionals,
        this.status,
        this.id,
    });

    factory DevotionalClass.fromJson(Map<String, dynamic> json) => DevotionalClass(
        devotionals: List<Devotional>.from(json["devotionals"].map((x) => Devotional.fromJson(x))),
        status: json["status"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "devotionals": List<dynamic>.from(devotionals.map((x) => x.toJson())),
        "status": status,
        "id": id,
    };
}

class Devotional {
    int id;
    String title;
    String devotionaltext;
    DateTime datePublished;
    String status;
    int likeCount;
    String rawtext;

    Devotional({
        this.id,
        this.title,
        this.devotionaltext,
        this.datePublished,
        this.status,
        this.likeCount,
        this.rawtext,
    });

    factory Devotional.fromJson(Map<String, dynamic> json) => Devotional(
        id: json["id"],
        title: json["title"],
        devotionaltext: json["devotionaltext"],
        datePublished: DateTime.parse(json["datePublished"]),
        status: json["status"],
        likeCount: json["likeCount"],
        rawtext: json["rawtext"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "devotionaltext": devotionaltext,
        "datePublished": datePublished.toIso8601String(),
        "status": status,
        "likeCount": likeCount,
        "rawtext": rawtext,
    };
}

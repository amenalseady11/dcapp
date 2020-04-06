// To parse this JSON data, do
//
//     final newsClass = newsClassFromJson(jsonString);

import 'dart:convert';

NewsClass newsClassFromJson(String str) => NewsClass.fromJson(json.decode(str));

String newsClassToJson(NewsClass data) => json.encode(data.toJson());

class NewsClass {
    List<News> news;
    String status;
    dynamic id;

    NewsClass({
        this.news,
        this.status,
        this.id,
    });

    factory NewsClass.fromJson(Map<String, dynamic> json) => NewsClass(
        news: List<News>.from(json["news"].map((x) => News.fromJson(x))),
        status: json["status"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "news": List<dynamic>.from(news.map((x) => x.toJson())),
        "status": status,
        "id": id,
    };
}

class News {
    int id;
    DateTime datePosted;
    String headline;
    String newsDescription;
    String status;
    int viewCount;

    News({
        this.id,
        this.datePosted,
        this.headline,
        this.newsDescription,
        this.status,
        this.viewCount,
    });

    factory News.fromJson(Map<String, dynamic> json) => News(
        id: json["id"],
        datePosted: DateTime.parse(json["datePosted"]),
        headline: json["headline"],
        newsDescription: json["newsDescription"],
        status: json["status"],
        viewCount: json["viewCount"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "datePosted": datePosted.toIso8601String(),
        "headline": headline,
        "newsDescription": newsDescription,
        "status": status,
        "viewCount": viewCount,
    };
}

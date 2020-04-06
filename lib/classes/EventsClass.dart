// To parse this JSON data, do
//
//     final eventsClass = eventsClassFromJson(jsonString);

import 'dart:convert';

EventsClass eventsClassFromJson(String str) => EventsClass.fromJson(json.decode(str));

String eventsClassToJson(EventsClass data) => json.encode(data.toJson());

class EventsClass {
    List<Event> events;
    String status;
    dynamic id;

    EventsClass({
        this.events,
        this.status,
        this.id,
    });

    factory EventsClass.fromJson(Map<String, dynamic> json) => EventsClass(
        events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
        status: json["status"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "events": List<dynamic>.from(events.map((x) => x.toJson())),
        "status": status,
        "id": id,
    };
}

class Event {
    int eventId;
    DateTime eventDate;
    String eventTime;
    String title;
    String description;
    String venue;
    String bannerurl;
    String status;

    Event({
        this.eventId,
        this.eventDate,
        this.eventTime,
        this.title,
        this.description,
        this.venue,
        this.bannerurl,
        this.status,
    });

    factory Event.fromJson(Map<String, dynamic> json) => Event(
        eventId: json["eventID"],
        eventDate: DateTime.parse(json["eventDate"]),
        eventTime: json["eventTime"],
        title: json["title"],
        description: json["description"],
        venue: json["venue"],
        bannerurl: json["bannerurl"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "eventID": eventId,
        "eventDate": eventDate.toIso8601String(),
        "eventTime": eventTime,
        "title": title,
        "description": description,
        "venue": venue,
        "bannerurl": bannerurl,
        "status": status,
    };
}

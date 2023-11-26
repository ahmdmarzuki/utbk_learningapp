// To parse this JSON data, do
//
//     final bannerResponse = bannerResponseFromJson(jsonString);

import 'dart:convert';

BannerResponse bannerResponseFromJson(String str) => BannerResponse.fromJson(json.decode(str));

String bannerResponseToJson(BannerResponse data) => json.encode(data.toJson());

class BannerResponse {
    int status;
    String message;
    List<BannerData> data;

    BannerResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory BannerResponse.fromJson(Map<String, dynamic> json) => BannerResponse(
        status: json["status"],
        message: json["message"],
        data: List<BannerData>.from(json["data"].map((x) => BannerData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class BannerData {
    String eventId;
    String eventTitle;
    String eventDescription;
    String eventImage;
    String eventUrl;

    BannerData({
        required this.eventId,
        required this.eventTitle,
        required this.eventDescription,
        required this.eventImage,
        required this.eventUrl,
    });

    factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
        eventId: json["event_id"],
        eventTitle: json["event_title"],
        eventDescription: json["event_description"],
        eventImage: json["event_image"],
        eventUrl: json["event_url"],
    );

    Map<String, dynamic> toJson() => {
        "event_id": eventId,
        "event_title": eventTitle,
        "event_description": eventDescription,
        "event_image": eventImage,
        "event_url": eventUrl,
    };
}

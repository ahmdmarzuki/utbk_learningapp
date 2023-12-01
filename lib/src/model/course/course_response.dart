// To parse this JSON data, do
//
//     final courseResponse = courseResponseFromJson(jsonString);

import 'dart:convert';

CourseResponse courseResponseFromJson(String str) => CourseResponse.fromJson(json.decode(str));

String courseResponseToJson(CourseResponse data) => json.encode(data.toJson());

class CourseResponse {
    int status;
    String message;
    List<CourseData> data;

    CourseResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory CourseResponse.fromJson(Map<String, dynamic> json) => CourseResponse(
        status: json["status"],
        message: json["message"],
        data: List<CourseData>.from(json["data"].map((x) => CourseData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class CourseData {
    String courseId;
    String majorName;
    String courseCategory;
    String courseName;
    String urlCover;
    int jumlahMateri;
    int jumlahDone;
    int progress;

    CourseData({
        required this.courseId,
        required this.majorName,
        required this.courseCategory,
        required this.courseName,
        required this.urlCover,
        required this.jumlahMateri,
        required this.jumlahDone,
        required this.progress,
    });

    factory CourseData.fromJson(Map<String, dynamic> json) => CourseData(
        courseId: json["course_id"],
        majorName: json["major_name"],
        courseCategory: json["course_category"],
        courseName: json["course_name"],
        urlCover: json["url_cover"],
        jumlahMateri: json["jumlah_materi"],
        jumlahDone: json["jumlah_done"],
        progress: json["progress"],
    );

    Map<String, dynamic> toJson() => {
        "course_id": courseId,
        "major_name": majorName,
        "course_category": courseCategory,
        "course_name": courseName,
        "url_cover": urlCover,
        "jumlah_materi": jumlahMateri,
        "jumlah_done": jumlahDone,
        "progress": progress,
    };
}

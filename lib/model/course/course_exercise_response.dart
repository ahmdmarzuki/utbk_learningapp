import 'dart:convert';

CourseExerciseResponse courseExerciseResponseFromJson(String str) => CourseExerciseResponse.fromJson(json.decode(str));

String courseExerciseResponseToJson(CourseExerciseResponse data) => json.encode(data.toJson());

class CourseExerciseResponse {
    int status;
    String message;
    List<CourseExerciseData> data;

    CourseExerciseResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory CourseExerciseResponse.fromJson(Map<String, dynamic> json) => CourseExerciseResponse(
        status: json["status"],
        message: json["message"],
        data: List<CourseExerciseData>.from(json["data"].map((x) => CourseExerciseData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class CourseExerciseData {
    String exerciseId;
    String exerciseTitle;
    String accessType;
    String icon;
    String exerciseUserStatus;
    String jumlahSoal;
    int jumlahDone;

    CourseExerciseData({
        required this.exerciseId,
        required this.exerciseTitle,
        required this.accessType,
        required this.icon,
        required this.exerciseUserStatus,
        required this.jumlahSoal,
        required this.jumlahDone,
    });

    factory CourseExerciseData.fromJson(Map<String, dynamic> json) => CourseExerciseData(
        exerciseId: json["exercise_id"],
        exerciseTitle: json["exercise_title"],
        accessType: json["access_type"],
        icon: json["icon"],
        exerciseUserStatus: json["exercise_user_status"],
        jumlahSoal: json["jumlah_soal"],
        jumlahDone: json["jumlah_done"],
    );

    Map<String, dynamic> toJson() => {
        "exercise_id": exerciseId,
        "exercise_title": exerciseTitle,
        "access_type": accessType,
        "icon": icon,
        "exercise_user_status": exerciseUserStatus,
        "jumlah_soal": jumlahSoal,
        "jumlah_done": jumlahDone,
    };
}

import 'package:dio/dio.dart';
import 'package:final_porject_edspert/src/data/model/course/course_exercise_response.dart';
import 'package:final_porject_edspert/src/data/model/course/course_response.dart';
import 'package:final_porject_edspert/src/data/model/headers/headers.dart';
import 'package:final_porject_edspert/src/domain/entity/course_list_response_entity.dart';

class CourseRemoteDataSource {
  Future<List<CourseDataModel>> getCourseList(String majorName) async {
    try {
      const url =
          'https://edspert.widyaedu.com/exercise/data_course?major_name=IPA&user_email=testerngbayu@gmail.com';
      final response = await Dio().get(
        url,
        options: Options(
          headers: {"x-api-key": "18be70c0-4e4d-44ff-a475-50c51ece99a0"},
        ),
      );

      final courseResponse = CourseListResponseModel.fromJson(response.data);

      return courseResponse.data;
    } catch (e) {
      print('Error at CourseRepository getCourseList $e');
      rethrow;
    }
  }

  Future<List<CourseExerciseData>> getCourseExerciseList(
      String courseId) async {
    try {
      const url = 'https://edspert.widyaedu.com/exercise/data_exercise';

      final response = await Dio().get(url,
          queryParameters: {
            "course_id": courseId,
            "user_email": "testerngbayu@gmail.com"
          },
          options: Options(
              headers: {"x-api-key": "18be70c0-4e4d-44ff-a475-50c51ece99a0"}));

      final courseExerciseData = CourseExerciseResponse.fromJson(response.data);

      return courseExerciseData.data;
    } catch (e) {
      print('Error at CourseRepository getCourseExerciseList $e');
      rethrow;
    }
  }
}

import 'package:dio/dio.dart';
import 'package:final_porject_edspert/model/course/course_response.dart';

class CourseRepository {
  Future<List<CourseData>> getCourseList() async {
    try {
      const url =
          'https://edspert.widyaedu.com/exercise/data_course?major_name=IPA&user_email=testerngbayu@gmail.com';
      final response = await Dio().get(url,
          options: Options(
              headers: {"x-api-key": "18be70c0-4e4d-44ff-a475-50c51ece99a0"},),);

      final courseResponse = CourseResponse.fromJson(response.data);

      return courseResponse.data;
    } catch (e) {
      print('Error at CourseRepository $e');
      rethrow;
    }
  }
}

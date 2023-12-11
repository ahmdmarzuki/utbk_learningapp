import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:final_porject_edspert/src/data/model/course_exercise_response.dart';
import 'package:final_porject_edspert/src/data/model/course_response.dart';
import 'package:final_porject_edspert/src/data/model/question_response_model.dart';

import '../../model/exercise_result_response_model.dart';
import '../../model/submit_answer_request_model.dart';

class CourseRemoteDatasource {
  final Dio client;

  const CourseRemoteDatasource({required this.client});
  Future<CourseResponse> getCourses(String majorName) async {
    try {
      const url = 'https://edspert.widyaedu.com/exercise/data_course';

      final result = await client.get(
        url,
        queryParameters: {
          'major_name': majorName,
          'user_email': 'testerngbayu@gmail.com',
        },
        options: Options(
          headers: {'x-api-key': '18be70c0-4e4d-44ff-a475-50c51ece99a0'},
        ),
      );
      log(result.data.toString());
      return CourseResponse.fromJson(result.data);
    } catch (error, stacktrace) {
      log(error.toString(), stackTrace: stacktrace);
      return CourseResponse();
    }
  }

  Future<ExerciseResponse> getExercises(
      {required String courseId, required String email}) async {
    try {
      const String url = 'https://edspert.widyaedu.com/exercise/data_exercise';

      final result = await client.get(
        url,
        queryParameters: {
          'course_id': courseId,
          'user_email': 'testerngbayu@gmail.com',
        },
        options: Options(
          headers: {'x-api-key': '18be70c0-4e4d-44ff-a475-50c51ece99a0'},
        ),
      );
      return ExerciseResponse.fromJson(result.data);
    } catch (error, stacktrace) {
      log(error.toString(), stackTrace: stacktrace);
      return ExerciseResponse();
    }
  }

  Future<QuestionResponseModel> getQuestions(
      {required String exerciseId, required String email}) async {
    try {
      const String url = 'https://edspert.widyaedu.com/exercise/kerjakan';

      final result = await client.post(
        url,
        data: {
          'exercise_id': exerciseId,
          'user_email': 'testerngbayu@gmail.com',
        },
        options: Options(
          headers: {'x-api-key': '18be70c0-4e4d-44ff-a475-50c51ece99a0'},
        ),
      );
      return QuestionResponseModel.fromJson(result.data);
    } catch (error, stacktrace) {
      log(error.toString(), stackTrace: stacktrace);
      return QuestionResponseModel();
    }
  }

  Future<bool> submitAnswers(
      {required SubmitAnswerRequestModel request}) async {
    try {
      const String url = 'https://edspert.widyaedu.com/exercise/input_jawaban';

      final result = await client.post(
        url,
        data: request.toMap(),
        options: Options(
          headers: {'x-api-key': '18be70c0-4e4d-44ff-a475-50c51ece99a0'},
        ),
      );
      print('result... ${result.data}');
      if (result.data['message'] == 'Sukses input jawaban') {
        return true;
      }

      return false;
    } catch (error, stacktrace) {
      log(error.toString(), stackTrace: stacktrace);
      return false;
    }
  }

  Future<ExerciseResultResponseModel> getExerciseResult(
      {required String exerciseId, required String email}) async {
    try {
      const String url = 'https://edspert.widyaedu.com/exercise/score_result';

      final result = await client.get(
        url,
        queryParameters: {
          'exercise_id': exerciseId,
          'user_email': email,
        },
        options: Options(
          headers: {'x-api-key': '18be70c0-4e4d-44ff-a475-50c51ece99a0'},
        ),
      );
      return ExerciseResultResponseModel.fromJson(result.data);
    } catch (error, stacktrace) {
      log(error.toString(), stackTrace: stacktrace);
      return ExerciseResultResponseModel();
    }
  }
}

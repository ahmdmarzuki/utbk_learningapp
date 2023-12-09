import 'package:dio/dio.dart';
import 'package:final_porject_edspert/src/data/datasource/remote/course_remote_datasource.dart';
import 'package:final_porject_edspert/src/data/datasource/remote/question_remote_datasource.dart';
import 'package:final_porject_edspert/src/domain/entity/course_list_entity.dart';
import 'package:final_porject_edspert/src/domain/entity/exercise_list_entity.dart';
import 'package:final_porject_edspert/src/domain/repository/course_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entity/question_list_entity.dart';
import '../model/course_exercise_response.dart';
import '../model/course_response.dart';
import '../model/question_response_model.dart';

class CourseRepositoryImpl implements CourseRepository{
  // final QuestionRemoteDatasource questionRemoteDatasource;
  final CourseRemoteDatasource remoteDatasource;

  CourseRepositoryImpl({required this.remoteDatasource});
  @override
  Future<List<CourseDataEntity>?> getCourses(String majorName) async {
    final response = await remoteDatasource.getCourses(majorName);
    if (response.data == null) {
      return null;
    }
    final data = CourseListEntity(
      status: response.status ?? -1,
      message: response.message ?? '',
      data: List<CourseData>.from(response.data ?? [])
          .map(
            (e) => CourseDataEntity(
              courseId: e.courseId ?? '',
              majorName: e.majorName ?? '',
              courseCategory: e.courseCategory ?? '',
              courseName: e.courseName ?? '',
              urlCover: e.urlCover ?? '',
              jumlahMateri: e.jumlahMateri ?? 0,
              jumlahDone: e.jumlahDone ?? 0,
              progress: e.progress ?? 0,
            ),
          )
          .toList(),
    );

    return data.data;
  }


  @override
  Future<List<ExerciseDataEntity>?> getExercisesByCourse(String courseId) async {
    final response = await remoteDatasource.getExercises(
      courseId: courseId,
      email: FirebaseAuth.instance.currentUser?.email ?? '',
    );

    if (response.data == null) {
      return null;
    }

    final data = ExerciseListEntity(
      status: response.status ?? -1,
      message: response.message ?? '',
      data: List<ExerciseData>.from(response.data ?? [])
          .map(
            (e) => ExerciseDataEntity(
              exerciseId: e.exerciseId ?? '',
              exerciseTitle: e.exerciseTitle ?? '',
              accessType: e.accessType ?? '',
              icon: e.icon ?? '',
              exerciseUserStatus: e.exerciseUserStatus ?? '',
              jumlahSoal: e.jumlahSoal ?? '',
              jumlahDone: e.jumlahDone ?? 0,
            ),
          )
          .toList(),
    );

    return data.data;
  }

  Future<List<QuestionListDataEntity>?> getQuestionsByExercise(
      String exerciseId) async {
    
    final response =
        await remoteDatasource.getQuestions(exerciseId: exerciseId, email: '');

    if ((response.data ?? []).isEmpty) {
      return null;
    }

    final data = QuestionListEntity(
      status: response.status ?? -1,
      message: response.message ?? '',
      data: List<QuestionData>.from(response.data ?? [])
          .map(
            (e) => QuestionListDataEntity(
              exerciseId: e.exerciseId ?? '',
              questionId: e.questionId ?? '',
              questionTitle: e.questionTitle ?? '',
              questionTitleImg: e.questionTitleImg ?? '',
              optionA: e.optionA ?? '',
              optionAImg: e.optionAImg ?? '',
              optionB: e.optionB ?? '',
              optionBImg: e.optionBImg ?? '',
              optionC: e.optionC ?? '',
              optionCImg: e.optionCImg ?? '',
              optionD: e.optionD ?? '',
              optionDImg: e.optionDImg ?? '',
              optionE: e.optionE ?? '',
              optionEImg: e.optionEImg ?? '',
              studentAnswer: e.studentAnswer ?? '',
            ),
          )
          .toList(),
    );

    return data.data;
  }

  

  // Future<List<QuestionData>> getQuestionList(String exerciseId) async {
  //   try {
  //     const url = 'https://edspert.widyaedu.com/exercise/kerjakan/';
  //     final response = await Dio().post(
  //       url,
  //       options: Options(
  //         headers: {"x-api-key": "18be70c0-4e4d-44ff-a475-50c51ece99a0"},
  //       ),
  //       data: {
  //         "course_id": exerciseId,
  //         "user_email": "testerngbayu@gmail.com",
  //       },
  //     );

  //     final questionData = QuestionResponse.fromJson(response.data);
  //     return questionData.data;
  //   } catch (e) {
  //     print('Error at QuestionRepository getQuestionList $e');

  //     rethrow;
  //   }
  // }
}

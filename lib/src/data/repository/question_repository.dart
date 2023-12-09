// import 'package:final_porject_edspert/src/data/datasource/remote/question_remote_datasource.dart';
// import 'package:final_porject_edspert/src/data/model/question_response_model.dart';
// import 'package:final_porject_edspert/src/domain/entity/question_list_entity.dart';
// import 'package:final_porject_edspert/src/domain/repository/course_repository.dart';

// class QuestionRepositoryImpl implements CourseRepository {
//   final QuestionRemoteDatasource datasource;

//   QuestionRepositoryImpl({required this.datasource});
//   Future<List<QuestionListDataEntity>?> getQuestionsByExercise(
//       String exerciseId) async {
//     final response =
//         await datasource.getQuestions(exerciseId: exerciseId, email: '');

//     if ((response.data ?? []).isEmpty) {
//       return null;
//     }

//     final data = QuestionListEntity(
//       status: response.status ?? -1,
//       message: response.message ?? '',
//       data: List<QuestionData>.from(response.data ?? [])
//           .map(
//             (e) => QuestionListDataEntity(
//               exerciseId: e.exerciseId ?? '',
//               questionId: e.questionId ?? '',
//               questionTitle: e.questionTitle ?? '',
//               questionTitleImg: e.questionTitleImg ?? '',
//               optionA: e.optionA ?? '',
//               optionAImg: e.optionAImg ?? '',
//               optionB: e.optionB ?? '',
//               optionBImg: e.optionBImg ?? '',
//               optionC: e.optionC ?? '',
//               optionCImg: e.optionCImg ?? '',
//               optionD: e.optionD ?? '',
//               optionDImg: e.optionDImg ?? '',
//               optionE: e.optionE ?? '',
//               optionEImg: e.optionEImg ?? '',
//               studentAnswer: e.studentAnswer ?? '',
//             ),
//           )
//           .toList(),
//     );

//     return data.data;
//   }
// }

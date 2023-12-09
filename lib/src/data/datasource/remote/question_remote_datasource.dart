// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:final_porject_edspert/src/data/model/question_response_model.dart';

// class QuestionRemoteDatasource {

//   final Dio client;

//   QuestionRemoteDatasource({required this.client});

//   Future<QuestionResponse> getQuestions({required String exerciseId, required String email}) async {
//     try {
//       const String url = 'https://edspert.widyaedu.com/exercise/kerjakan';

//       final result = await client.post(
//         url,
//         data: {
//           'exercise_id': exerciseId,
//           'user_email': email,
//         },
//         options: Options(
//           headers: {'x-api-key': '18be70c0-4e4d-44ff-a475-50c51ece99a0'},
//         ),
//       );
//       return QuestionResponse.fromJson(result.data);
//     } catch (error, stacktrace) {
//       log(error.toString(), stackTrace: stacktrace);
//       return QuestionResponse();
//     }
//   }

  
// }
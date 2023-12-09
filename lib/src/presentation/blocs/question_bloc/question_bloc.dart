import 'package:bloc/bloc.dart';
import 'package:final_porject_edspert/src/domain/entity/question_list_entity.dart';
import 'package:final_porject_edspert/src/domain/usecases/courses_usecases/get_exercise_result_usecase.dart';
import 'package:final_porject_edspert/src/domain/usecases/courses_usecases/get_question_by_exercise_usecase.dart';
import 'package:final_porject_edspert/src/domain/usecases/courses_usecases/submit_exercise_answer.dart';
import 'package:meta/meta.dart';

import '../../../data/model/submit_answer_request_model.dart';
import '../../../domain/entity/exercise_result_response_entity.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  // final QuestionRepository questionRepository;
  final GetQuestionByExerciseUsecase getQuestionByExerciseUsecase;
  final SubmitExerciseAnswerUsecase submitExerciseAnswerUsecase;
  final GetExercisesResultUsecase getExercisesResultUsecase;
  QuestionBloc(
      {required this.getQuestionByExerciseUsecase,
      required this.submitExerciseAnswerUsecase,
      required this.getExercisesResultUsecase})
      : super(QuestionInitial()) {
    on<QuestionEvent>(
      (events, emit) async {
        if (events is GetQuestionEvent) {
          emit(QuestionLoading());

          final List<QuestionListDataEntity>? data =
              await getQuestionByExerciseUsecase(events.exerciseId);
          if (data == null) {
            emit(QuestionFailed(errorMessage: 'Data Tidak Ada'));
          } else {
            emit(QuestionSuccess(questionList: data));
          }
        }

        if (events is SubmitAnswerEvent) {
          emit(SubmitLoading());

          final bool submitAnswer =
              await submitExerciseAnswerUsecase(events.request);
          if (submitAnswer) {
            emit(SubmitSuccess());
          } else {
            emit(SubmitFailed(errorMessage: 'Gagal ngumpulin jawaban broo'));
          }
        }

        if (events is GetExerciseResultEvent) {
          emit(ExerciseResultLoading());

          final ExerciseResultResponseEntity? exerciseResult =
              await getExercisesResultUsecase(events.exerciseId);
          if (exerciseResult == null) {
            emit(ExerciseResultFailed(errorMessage: 'Datanya gk ada bro'));
          } else {
            emit(ExerciseResultSuccess());
          }
        }
      },
    );
  }
}

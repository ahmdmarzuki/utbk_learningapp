import 'package:bloc/bloc.dart';
import 'package:final_porject_edspert/src/domain/entity/question_list_entity.dart';
import 'package:final_porject_edspert/src/domain/usecases/courses_usecases/get_question_by_exercise_usecase.dart';
import 'package:meta/meta.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  // final QuestionRepository questionRepository;
  final GetQuestionByExerciseUsecase getQuestionByExerciseUsecase;
  QuestionBloc({required this.getQuestionByExerciseUsecase})
      : super(QuestionInitial()) {
    on<QuestionEvent>((events, emit) async {
      if (events is GetQuestionEvent) {
        emit(QuestionLoading());

        final List<QuestionListDataEntity>? data =
            await getQuestionByExerciseUsecase(events.exerciseId);
        if (data == null) {
          emit(QuestionFailed(errorMessage: 'Data Tidak Ada'));
        } else {
          emit(QuestionSuccess(questionList: data));
        }

        // emit(QuestionSuccess(questionList: data));
      }
    });
  }
}

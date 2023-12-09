import 'package:bloc/bloc.dart';
import 'package:final_porject_edspert/src/domain/entity/question_answer_entity.dart';
import 'package:meta/meta.dart';

import '../../../../domain/entity/question_list_entity.dart';

part 'question_form_state.dart';

class QuestionFormCubit extends Cubit<QuestionFormState> {
  QuestionFormCubit()
      : super(
          QuestionFormState(
            questionAnswers: [],
            activeQuestionindex: 0,
            activeQuestionId: '',
          ),
        );

  void navigateToQuestionIndex({
    required List<QuestionListDataEntity> questions,
    required int index,
  }) {
    emit(state.copyWith(
        activeQuestionindex: index,
        activeQuestionId: questions[index].questionId));
  }

  void initStudentAnsweredQuestions(
      {required List<QuestionListDataEntity> questions}) {
    for (QuestionListDataEntity data in questions) {
      if (data.studentAnswer.isNotEmpty) {
        List<QuestionAnswer> updateQuestionAnswers =
            List.from(state.questionAnswers);
        if (updateQuestionAnswers
            .any((element) => element.questionId == data.questionId)) {
          int indexToUpdate = state.questionAnswers
              .indexWhere((element) => element.questionId == data.questionId);
          updateQuestionAnswers[indexToUpdate] = QuestionAnswer(
              questionId: data.questionId, answer: data.studentAnswer);
        } else {
          updateQuestionAnswers.add(QuestionAnswer(
              questionId: data.questionId, answer: data.studentAnswer));
        }
        emit(state.copyWith(questionAnswer: updateQuestionAnswers));
      }
    }
  }

  void updateAnswerToQuestion(
      {required String questionId, required String answer}) {
    List<QuestionAnswer> updateQuestionAnswers =
        List.from(state.questionAnswers);

    if (updateQuestionAnswers
        .any((element) => element.questionId == questionId)) {
      int indexToUpdate = updateQuestionAnswers
          .indexWhere((element) => element.questionId == questionId);
      updateQuestionAnswers[indexToUpdate] =
          QuestionAnswer(questionId: questionId, answer: answer);
    } else {
      updateQuestionAnswers
          .add(QuestionAnswer(questionId: questionId, answer: answer));
    }

    emit(state.copyWith(questionAnswer: updateQuestionAnswers));
  }
}

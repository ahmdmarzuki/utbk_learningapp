part of 'question_form_cubit.dart';

class QuestionFormState {
  final List<QuestionAnswer> questionAnswers;
  final int activeQuestionindex;
  final String activeQuestionId;

  QuestionFormState(
      {required this.questionAnswers,
      required this.activeQuestionindex,
      required this.activeQuestionId});

  QuestionFormState copyWith({
    List<QuestionAnswer>? questionAnswer,
    int? activeQuestionindex,
    String? activeQuestionId,
  }) {
    return QuestionFormState(
        questionAnswers: questionAnswer ?? this.questionAnswers,
        activeQuestionindex: activeQuestionindex ?? this.activeQuestionindex,
        activeQuestionId: activeQuestionId ?? this.activeQuestionId);
  }
}

part of 'question_bloc.dart';

@immutable
sealed class QuestionState {}

final class QuestionInitial extends QuestionState {}
final class QuestionLoading extends QuestionState {}

final class QuestionSuccess extends QuestionState {
  final List<QuestionListDataEntity> questionList;

  QuestionSuccess({required this.questionList});
}

final class QuestionFailed extends QuestionState {
  final String errorMessage;

  QuestionFailed({required this.errorMessage});
}

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

final class SubmitLoading extends QuestionState {}

final class SubmitSuccess extends QuestionState {}

final class SubmitFailed extends QuestionState {
  final String errorMessage;

  SubmitFailed({required this.errorMessage});
}

final class ExerciseResultLoading extends QuestionState {}

final class ExerciseResultSuccess extends QuestionState {}

final class ExerciseResultFailed extends QuestionState {
  final String errorMessage;

  ExerciseResultFailed({required this.errorMessage});
}

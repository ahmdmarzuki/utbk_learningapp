part of 'question_bloc.dart';

@immutable
sealed class QuestionEvent {}

class GetQuestionEvent extends QuestionEvent {
  final String exerciseId;

  GetQuestionEvent({required this.exerciseId});
}

class SubmitAnswerEvent extends QuestionEvent {
  final SubmitAnswerRequestModel request;

  SubmitAnswerEvent({required this.request});
}

class GetExerciseResultEvent extends QuestionEvent {
  final String exerciseId;

  GetExerciseResultEvent({required this.exerciseId});
}

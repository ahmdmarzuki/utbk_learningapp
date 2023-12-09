part of 'question_bloc.dart';

@immutable
sealed class QuestionEvent {}

class GetQuestionEvent extends QuestionEvent{
  final String exerciseId;

  GetQuestionEvent({required this.exerciseId});
}

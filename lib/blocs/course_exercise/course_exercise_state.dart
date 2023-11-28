part of 'course_exercise_bloc.dart';

@immutable
sealed class CourseExerciseState {}

final class CourseExerciseInitial extends CourseExerciseState {}

final class CourseExerciseLoading extends CourseExerciseState {}

final class CourseExerciseSuccess extends CourseExerciseState {
  final List<CourseExerciseData> courseExerciseList;

  CourseExerciseSuccess({required this.courseExerciseList});
}

final class CourseExerciseFailed extends CourseExerciseState {
  final String errorMessage;

  CourseExerciseFailed({required this.errorMessage});
}
part of 'course_bloc.dart';

@immutable
sealed class CourseState {}

final class CourseInitial extends CourseState {}

final class CourseLoading extends CourseState {}

final class CourseSuccess extends CourseState {
  final List<CourseDataEntity> courseList;
  // final List<ExerciseData> exerciseList;

  CourseSuccess({ required this.courseList});
}

final class CourseFailed extends CourseState {
  final String errorMessage;

  CourseFailed({required this.errorMessage});
}

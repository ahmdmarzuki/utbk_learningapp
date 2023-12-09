part of 'course_exercise_bloc.dart';

@immutable
sealed class CourseExerciseEvent {}

class GetCourseExerciseEvent extends CourseExerciseEvent {
  final String courseId;
  // final String exerciseId;

  GetCourseExerciseEvent({required this.courseId});
}

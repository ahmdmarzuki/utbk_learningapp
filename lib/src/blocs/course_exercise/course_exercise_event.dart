part of 'course_exercise_bloc.dart';

@immutable
sealed class CourseExerciseEvent {}

class GetCourseExerciseEvent extends CourseExerciseEvent {
  final String courseId;

  GetCourseExerciseEvent({required this.courseId});
}

part of 'course_bloc.dart';

@immutable
sealed class CourseEvent {}

class GetCourseListEvent extends CourseEvent {
  final String majorName;
  // final String courseId;

  GetCourseListEvent({required this.majorName});
}



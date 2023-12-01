part of 'course_bloc.dart';

@immutable
sealed class CourseEvent {}

class GetCourseListEvent extends CourseEvent {
  final String majorName;

  GetCourseListEvent({required this.majorName});
}



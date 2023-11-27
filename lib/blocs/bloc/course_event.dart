part of 'course_bloc.dart';

@immutable
sealed class CourseEvent {}

class GetCouseListEvent extends CourseEvent{
  final String majorName;

  GetCouseListEvent({required this.majorName});

}

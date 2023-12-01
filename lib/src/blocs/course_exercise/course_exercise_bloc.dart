import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/course/course_exercise_response.dart';
import '../../repository/course_repo.dart';

part 'course_exercise_event.dart';
part 'course_exercise_state.dart';

class CourseExerciseBloc
    extends Bloc<CourseExerciseEvent, CourseExerciseState> {
  final CourseRepository courseRepository;
  CourseExerciseBloc({required this.courseRepository})
      : super(CourseExerciseInitial()) {
    on<CourseExerciseEvent>((events, emit) async {
      if (events is GetCourseExerciseEvent) {
        emit(CourseExerciseLoading());

        final data =
            await courseRepository.getCourseExerciseList(events.courseId);

        emit(
          CourseExerciseSuccess(courseExerciseList: data),
        );
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:final_porject_edspert/src/data/model/course/course_exercise_response.dart';
import 'package:final_porject_edspert/src/data/repository/course_repository_impl.dart';
import 'package:meta/meta.dart';

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

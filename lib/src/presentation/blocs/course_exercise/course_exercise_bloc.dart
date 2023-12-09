import 'package:bloc/bloc.dart';
import 'package:final_porject_edspert/src/domain/entity/exercise_list_entity.dart';
import 'package:final_porject_edspert/src/domain/usecases/courses_usecases/get_exercise_by_courses_usecase.dart';
import 'package:meta/meta.dart';


part 'course_exercise_event.dart';
part 'course_exercise_state.dart';

class CourseExerciseBloc
    extends Bloc<CourseExerciseEvent, CourseExerciseState> {
  // final CourseRepositoryImpl courseRepository;
  final GetExercisesByCourseUsecase getExercisesByCourseUsecase;
  CourseExerciseBloc({required this.getExercisesByCourseUsecase})
      : super(CourseExerciseInitial()) {
    on<CourseExerciseEvent>((events, emit) async {
      if (events is GetCourseExerciseEvent) {
        emit(CourseExerciseLoading());

        final List<ExerciseDataEntity>? getExercises =
            await getExercisesByCourseUsecase(events.courseId);
        if (getExercises == null) {
          emit(CourseExerciseFailed(errorMessage: 'Something wrong'));
        } else {
          emit(CourseExerciseSuccess(courseExerciseList: getExercises));
        }

      }
    });
  }
}

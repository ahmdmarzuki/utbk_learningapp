import 'package:bloc/bloc.dart';
import 'package:final_porject_edspert/src/domain/entity/course_list_entity.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/courses_usecases/get_courses_usecases.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  // final CourseRepositoryImpl courseRepository;
  final GetCoursesUsecase getCoursesUsecase;

  CourseBloc({required this.getCoursesUsecase}) : super(CourseInitial()) {
    on<CourseEvent>(
      (events, emit) async {
        if (events is GetCourseListEvent) {
          emit(CourseLoading());

          final List<CourseDataEntity>? getCourses =
              await getCoursesUsecase(events.majorName);
          if (getCourses == null) {
            emit(CourseFailed(errorMessage: 'Something wrong'));
          } else {
            emit(CourseSuccess(courseList: getCourses));
          }
        }
      },
    );
  }
}

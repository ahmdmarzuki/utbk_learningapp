import 'package:bloc/bloc.dart';
import 'package:final_porject_edspert/src/data/model/course/course_response.dart';
import 'package:final_porject_edspert/src/data/repository/course_repository_impl.dart';
import 'package:meta/meta.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CourseRepository courseRepository;

  CourseBloc({required this.courseRepository}) : super(CourseInitial()) {
    on<CourseEvent>(
      (events, emit) async {
        if (events is GetCourseListEvent) {
          emit(CourseLoading());

          final data = await courseRepository.getCourseList(events.majorName);

          emit(CourseSuccess(courseList: data));
        } 
      },
    );
  }
}

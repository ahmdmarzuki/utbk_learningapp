import 'package:bloc/bloc.dart';
import 'package:final_porject_edspert/model/course/course_response.dart';
import 'package:final_porject_edspert/repository/course_repo.dart';
import 'package:meta/meta.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CourseRepository courseRepository;

  CourseBloc({required this.courseRepository} ) : super(CourseInitial()) {
    on<CourseEvent>((events, emit) async {
      if (events is GetCouseListEvent) {
        emit(CourseLoading());

        final data = await courseRepository.getCourseList(events.majorName);

        emit(CourseSuccess(courseList: data));
      }
    });
  }
}

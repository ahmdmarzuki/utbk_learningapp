import 'package:final_porject_edspert/src/domain/entity/course_list_response_entity.dart';
import 'package:final_porject_edspert/src/domain/entity/exercise_list_response_entity.dart';

abstract class CourseRepository {
  /// course List
  Future<List<CourseDataEntity>?> getCourses(String majorName);

  /// Exercise List
  Future<List<ExerciseDataEntity>?> getExerciseByCourse(String courseId);
}

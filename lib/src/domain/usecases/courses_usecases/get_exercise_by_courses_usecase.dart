import 'package:final_porject_edspert/src/domain/entity/exercise_list_entity.dart';

import '../../repository/course_repository.dart';

class GetExercisesByCourseUsecase {
  final CourseRepository repository;

  const GetExercisesByCourseUsecase({required this.repository});

  Future<List<ExerciseDataEntity>?> call(String courseId) async =>
      await repository.getExercisesByCourse(courseId);
}

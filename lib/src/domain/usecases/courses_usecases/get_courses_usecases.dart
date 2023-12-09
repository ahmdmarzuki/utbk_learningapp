import 'package:final_porject_edspert/src/domain/entity/course_list_entity.dart';

import '../../repository/course_repository.dart';

class GetCoursesUsecase {
  final CourseRepository repository;

  const GetCoursesUsecase({required this.repository});

  Future<List<CourseDataEntity>?> call(String majorName) async =>
      await repository.getCourses(majorName);
}

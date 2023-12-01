import 'package:final_porject_edspert/src/domain/entity/course_list_response_entity.dart';
import 'package:final_porject_edspert/src/domain/entity/exercise_list_response_entity.dart';
import 'package:final_porject_edspert/src/domain/repository/course_repository.dart';

import '../datasource/remote/course_remote_datasource.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CourseRemoteDataSource remoteDataSource;

  CourseRepositoryImpl({required this.remoteDataSource});
  @override
  Future<List<CourseDataEntity>?> getCourses(String majorName) async {
    final response = await remoteDataSource.getCourseList(majorName);

    if (response.isEmpty) {
      return null;
    }

    final data = CourseListResponseEntity(status: response., message: , data: data)
  }

  @override
  Future<List<ExerciseDataEntity>?> getExerciseByCourse(String courseId) {
    // TODO: implement getExercise
    throw UnimplementedError();
  }
}

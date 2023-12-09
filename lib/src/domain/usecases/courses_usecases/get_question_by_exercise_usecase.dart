import 'package:final_porject_edspert/src/domain/entity/question_list_entity.dart';

import '../../repository/course_repository.dart';

class GetQuestionByExerciseUsecase {
  final CourseRepository repository;

  const GetQuestionByExerciseUsecase({required this.repository});

  Future<List<QuestionListDataEntity>?> call(String exerciseId) async =>
      await repository.getQuestionsByExercise(exerciseId);
}

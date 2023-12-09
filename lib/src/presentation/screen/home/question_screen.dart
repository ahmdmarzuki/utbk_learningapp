import 'package:final_porject_edspert/src/data/datasource/remote/course_remote_datasource.dart';
import 'package:final_porject_edspert/src/domain/entity/exercise_list_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/question_bloc/question_bloc.dart';

class QuestionScreen extends StatelessWidget {
  final ExerciseDataEntity exercise;
  final CourseRemoteDatasource? remoteDatasource;
  final int currentIndex = 0;

  const QuestionScreen(
      {super.key, required this.exercise, this.remoteDatasource});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<QuestionBloc, QuestionState>(
      builder: (context, state) {
        print(state.runtimeType);
        if (state is QuestionSuccess) {
          return ListView.builder(
            itemCount: state.questionList.length,
            itemBuilder: ((context, index) {
              return Text(
                state.questionList[index].exerciseId,
                style: TextStyle(fontSize: 14),
              );
            }),
          );
        }
        return CircularProgressIndicator();
      },
    ));
  }
}

import 'package:final_porject_edspert/src/data/datasource/remote/course_remote_datasource.dart';
import 'package:final_porject_edspert/src/domain/entity/exercise_list_entity.dart';
import 'package:final_porject_edspert/src/presentation/blocs/question_bloc/question_form_cubit/question_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entity/question_list_entity.dart';
import '../../blocs/course/course_bloc.dart';
import '../../blocs/question_bloc/question_bloc.dart';

class QuestionScreen extends StatefulWidget {
  // final ExerciseDataEntity exercise;
  // final CourseRemoteDatasource? remoteDatasource;

  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  String exerciseId = '';
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      exerciseId = ModalRoute.of(context)?.settings.arguments as String;
      context
          .read<QuestionBloc>()
          .add(GetQuestionEvent(exerciseId: exerciseId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<QuestionBloc, QuestionState>(
        listener: ((context, state) {
          if (state is SubmitSuccess) {
            context
                .read<QuestionBloc>()
                .add(GetExerciseResultEvent(exerciseId: exerciseId));
          }
        }),
        buildWhen: (previous, current) =>
            (current is QuestionLoading) ||
            (previous is QuestionLoading && current is QuestionSuccess) ||
            (previous is QuestionSuccess && current is QuestionFailed),
        builder: (context, state) {
          List<QuestionListDataEntity> questions = [];
          if (state is QuestionSuccess) {
            questions = state.questionList;
          }
          if (questions.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return BlocBuilder<QuestionFormCubit, QuestionFormState>(
              builder: (context, state) {
            print(state.runtimeType);
            int activeQuestionindex = state.activeQuestionindex;

            QuestionListDataEntity activeQuestion =
                questions[activeQuestionindex];
            String activeQuestionId = state.activeQuestionId;
            // String? selectedAnswer = state.questionAnswers
            //     .firstWhere((element) => element.questionId == activeQuestionId)
            //     .answer;

            return Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Text(questions[activeQuestionindex].questionTitle);
                    })
              ],
            );
          });
        },
      ),
    );
  }
}

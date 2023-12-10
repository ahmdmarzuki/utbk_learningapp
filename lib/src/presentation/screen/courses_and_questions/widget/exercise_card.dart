import 'package:final_porject_edspert/src/domain/entity/exercise_list_entity.dart';
import 'package:final_porject_edspert/src/presentation/blocs/course_exercise/course_exercise_bloc.dart';
import 'package:final_porject_edspert/src/presentation/screen/courses_and_questions/question_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/color/colors.dart';
import '../../../widget/text/heading.dart';
import '../../../widget/text/sub_heading1.dart';

import '../../../blocs/question_bloc/question_bloc.dart';
import 'card_image.dart';

class ExerciseCard extends StatelessWidget {
  // final QuestionRemoteDatasource questionRemoteDatasource;
  final ExerciseDataEntity exercise;
  // final QuestionData question;
  // final QuestionData question;
  const ExerciseCard({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseExerciseBloc, CourseExerciseState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context
                .read<QuestionBloc>()
                .add(GetQuestionEvent(exerciseId: exercise.exerciseId));

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const QuestionScreen()),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: HexColor.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardImage(
                    image: exercise.icon,
                    height: 42,
                    width: 42,
                  ),

                  // text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Heading(
                          text: exercise.exerciseTitle, color: HexColor.black),
                      SubHeading1(
                        text: "${exercise.jumlahDone}/${exercise.jumlahSoal}",
                        color: HexColor.grey,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

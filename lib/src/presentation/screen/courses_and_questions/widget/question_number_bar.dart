import 'package:final_porject_edspert/src/domain/entity/question_answer_entity.dart';
import 'package:final_porject_edspert/src/domain/entity/question_list_entity.dart';
import 'package:final_porject_edspert/src/presentation/blocs/question_bloc/question_form_cubit/question_form_cubit.dart';
import 'package:final_porject_edspert/src/utils/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionNumbersBarWidget extends StatelessWidget {
  const QuestionNumbersBarWidget({
    super.key,
    required this.questions,
    required this.activeQuestionId,
    required this.questionAnswers,
    required this.selectedAnswer,
    required this.activeQuestionindex,
  });

  final List<QuestionAnswer> questionAnswers;
  final List<QuestionListDataEntity> questions;
  final String activeQuestionId;
  final List<String?> selectedAnswer;
  final int activeQuestionindex;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(width: 20),
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                questions.length,
                (index) {
                  bool isAnswered = questionAnswers.any(
                    (element) =>
                        element.questionId == questions[index].questionId,
                  );
                  // bool isAnswered = selectedAnswer.any((element) =>
                  //       element.questionId == questions[index].questionId,);

                  return InkWell(
                    onTap: () {
                      // print(index);
                      // print(activeQuestionindex);
                      context.read<QuestionFormCubit>().navigateToQuestionIndex(
                            index: index,
                            questions: questions,
                          );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 20),
                      // padding: EdgeInsets.all(10),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: HexColor.blue_,
                        ),
                        color: activeQuestionindex == index && !isAnswered
                            ? Colors.blue.shade100
                            : activeQuestionindex == index && isAnswered
                                ? Colors.blue.shade800
                                : isAnswered
                                    ? HexColor.blue_
                                    : HexColor.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontWeight:
                                isAnswered ? FontWeight.w800 : FontWeight.w400,
                            color: isAnswered ? HexColor.white : HexColor.blue_,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

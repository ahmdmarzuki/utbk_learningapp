import 'package:final_porject_edspert/src/domain/entity/question_list_entity.dart';
import 'package:final_porject_edspert/src/presentation/blocs/question_bloc/question_form_cubit/question_form_cubit.dart';
import 'package:final_porject_edspert/src/presentation/widget/text/sub_heading1.dart';
import 'package:final_porject_edspert/src/utils/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionOptionWidget extends StatelessWidget {
  const QuestionOptionWidget({
    super.key,
    required this.selectedAnswers,
    required this.context,
    required this.activeQuestionId,
    required this.activeQuestion,
    required this.optionType,
  });

  final List<String?> selectedAnswers;
  final BuildContext context;
  final String activeQuestionId;
  final QuestionListDataEntity activeQuestion;
  final String optionType;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (selectedAnswers.firstOrNull != optionType) {
          context.read<QuestionFormCubit>().updateAnswerToQuestion(
              questionId: activeQuestionId, answer: optionType);
        } else if (selectedAnswers.firstOrNull == optionType) {
          context
              .read<QuestionFormCubit>()
              .updateAnswerToQuestion(questionId: activeQuestionId, answer: '');
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
            color: selectedAnswers.firstOrNull == optionType
                ? HexColor.blue_
                : HexColor.white,
            border: Border.all(color: HexColor.grey.withAlpha(70)),
            borderRadius: BorderRadius.circular(12)),
        child: Row(children: [
          SubHeading(
            text: optionType == 'A'
                ? "A."
                : optionType == 'B'
                    ? "B."
                    : optionType == 'C'
                        ? "C."
                        : optionType == 'D'
                            ? "D."
                            : "E.",
            color: selectedAnswers.firstOrNull == optionType
                ? HexColor.white
                : HexColor.black,
            fontSize: 14,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: HtmlWidget(
                optionType == 'A'
                    ? activeQuestion.optionA
                    : optionType == 'B'
                        ? activeQuestion.optionB
                        : optionType == 'C'
                            ? activeQuestion.optionC
                            : optionType == 'D'
                                ? activeQuestion.optionD
                                : activeQuestion.optionE,
                textStyle: GoogleFonts.poppins(
                    fontSize: 14,
                    color: selectedAnswers.firstOrNull == optionType
                        ? HexColor.white
                        : HexColor.black)),
          )
        ]),
      ),
    );
  }
}
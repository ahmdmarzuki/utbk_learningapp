import 'package:final_porject_edspert/src/data/datasource/remote/course_remote_datasource.dart';
import 'package:final_porject_edspert/src/data/model/submit_answer_request_model.dart';
import 'package:final_porject_edspert/src/domain/entity/exercise_list_entity.dart';
import 'package:final_porject_edspert/src/presentation/blocs/question_bloc/question_form_cubit/question_form_cubit.dart';
import 'package:final_porject_edspert/src/presentation/screen/feature/widgets/question_number_bar.dart';
import 'package:final_porject_edspert/src/utils/color/colors.dart';
import 'package:final_porject_edspert/src/utils/text/appbar_heading.dart';
import 'package:final_porject_edspert/src/utils/text/banner_text.dart';
import 'package:final_porject_edspert/src/utils/text/heading.dart';
import 'package:final_porject_edspert/src/utils/text/sub_heading1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';

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
      appBar: AppBar(
        foregroundColor: HexColor.white,
        backgroundColor: HexColor.blue_,
        centerTitle: true,
        title: BannerText(text: "Latihan Soal", color: HexColor.white),
      ),
      body: SafeArea(
        child: BlocConsumer<QuestionBloc, QuestionState>(
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

              List<String?> selectedAnswers = state.questionAnswers
                  .where((e) => e.questionId == activeQuestionId)
                  .map((e) => e.answer)
                  .toList();

              return Column(
                children: [
                  // Text(selectedAnswer.toString()),
                  QuestionNumbersBarWidget(
                    questions: questions,
                    activeQuestionId: activeQuestionId,
                    questionAnswers: state.questionAnswers,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        children: [
                          SubHeading1(
                            text:
                                "Soal nomor ${(activeQuestionindex.toInt() + 1).toString()}",
                            color: HexColor.grey,
                            fontSize: 14,
                          ),
                          const SizedBox(height: 30),
                          HtmlWidget(
                            activeQuestion.questionTitle,
                            textStyle: GoogleFonts.poppins(fontSize: 14),
                          ),
                          const SizedBox(height: 30),
                          QuestionOption(selectedAnswers, context,
                              activeQuestionId, activeQuestion, 'A'),
                          const SizedBox(height: 12),
                          QuestionOption(selectedAnswers, context,
                              activeQuestionId, activeQuestion, 'B'),
                          const SizedBox(height: 12),
                          QuestionOption(selectedAnswers, context,
                              activeQuestionId, activeQuestion, 'C'),
                          const SizedBox(height: 12),
                          QuestionOption(selectedAnswers, context,
                              activeQuestionId, activeQuestion, 'D'),
                          const SizedBox(height: 12),
                          QuestionOption(selectedAnswers, context,
                              activeQuestionId, activeQuestion, 'E'),
                          SizedBox(height: 30),
                          SizedBox(
                            child: activeQuestionindex < questions.length - 1
                                ? Container()
                                : InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => Dialog(
                                                child: Container(
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      color: HexColor.blue_),
                                                ),
                                              ));
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: HexColor.blue_,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Center(
                                        child: SubHeading1(
                                          text: "Kumpulkan Jawaban",
                                          fontSize: 16,
                                          color: HexColor.white,
                                        ),
                                      ),
                                    ),
                                  ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            });
          },
        ),
      ),
    );
  }

  InkWell QuestionOption(
      List<String?> selectedAnswers,
      BuildContext context,
      String activeQuestionId,
      QuestionListDataEntity activeQuestion,
      String optionType) {
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
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            color: selectedAnswers.firstOrNull == optionType
                ? HexColor.blue_
                : HexColor.white,
            border: Border.all(color: HexColor.grey.withAlpha(70)),
            borderRadius: BorderRadius.circular(12)),
        child: Row(children: [
          SubHeading1(
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

// List<String> questionIds = state
//                                           .questionAnswers
//                                           .map((e) => e.questionId)
//                                           .toList();
//                                       List<String> answers = state
//                                           .questionAnswers
//                                           .map((e) => e.answer)
//                                           .toList();
//                                       context.read<QuestionBloc>().add(
//                                             SubmitAnswerEvent(
//                                               request: SubmitAnswerRequestModel(
//                                                   userEmail: '',
//                                                   exerciseId: exerciseId,
//                                                   questionIds: questionIds,
//                                                   answers: answers),
//                                             ),
                                            
//                                           );
//                                           Navigator.pop(context);

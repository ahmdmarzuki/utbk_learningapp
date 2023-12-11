import 'package:final_porject_edspert/src/data/datasource/remote/course_remote_datasource.dart';
import 'package:final_porject_edspert/src/data/model/submit_answer_request_model.dart';
import 'package:final_porject_edspert/src/domain/entity/exercise_list_entity.dart';
import 'package:final_porject_edspert/src/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:final_porject_edspert/src/presentation/blocs/question_bloc/question_form_cubit/question_form_cubit.dart';
import 'package:final_porject_edspert/src/presentation/screen/courses_and_questions/result_screen.dart';
import 'package:final_porject_edspert/src/presentation/screen/courses_and_questions/widget/question_number_bar.dart';
import 'package:final_porject_edspert/src/presentation/screen/courses_and_questions/widget/question_option_widget.dart';
import 'package:final_porject_edspert/src/utils/color/colors.dart';
import 'package:final_porject_edspert/src/presentation/widget/text/appbar_heading.dart';
import 'package:final_porject_edspert/src/presentation/widget/text/banner_text.dart';
import 'package:final_porject_edspert/src/presentation/widget/text/heading.dart';
import 'package:final_porject_edspert/src/presentation/widget/text/sub_heading1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/entity/question_list_entity.dart';
import '../../blocs/course/course_bloc.dart';
import '../../blocs/question_bloc/question_bloc.dart';

class QuestionScreen extends StatefulWidget {
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
                  QuestionNumbersBarWidget(
                    questions: questions,
                    activeQuestionId: activeQuestionId,
                    questionAnswers: state.questionAnswers,
                    selectedAnswer: selectedAnswers,
                    activeQuestionindex: activeQuestionindex,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        children: [
                          SubHeading(
                            text:
                                "Soal nomor ${(activeQuestionindex.toInt() + 1).toString()}",
                            color: HexColor.grey,
                            fontSize: 16,
                          ),
                          const SizedBox(height: 30),
                          HtmlWidget(
                            activeQuestion.questionTitle,
                            textStyle: GoogleFonts.poppins(fontSize: 14),
                          ),
                          const SizedBox(height: 30),
                          QuestionOptionWidget(
                              selectedAnswers: selectedAnswers,
                              context: context,
                              activeQuestionId: activeQuestionId,
                              activeQuestion: activeQuestion,
                              optionType: 'A'),
                          const SizedBox(height: 12),
                          QuestionOptionWidget(
                              selectedAnswers: selectedAnswers,
                              context: context,
                              activeQuestionId: activeQuestionId,
                              activeQuestion: activeQuestion,
                              optionType: 'B'),
                          const SizedBox(height: 12),
                          QuestionOptionWidget(
                              selectedAnswers: selectedAnswers,
                              context: context,
                              activeQuestionId: activeQuestionId,
                              activeQuestion: activeQuestion,
                              optionType: 'C'),
                          const SizedBox(height: 12),
                          QuestionOptionWidget(
                              selectedAnswers: selectedAnswers,
                              context: context,
                              activeQuestionId: activeQuestionId,
                              activeQuestion: activeQuestion,
                              optionType: 'D'),
                          const SizedBox(height: 12),
                          QuestionOptionWidget(
                              selectedAnswers: selectedAnswers,
                              context: context,
                              activeQuestionId: activeQuestionId,
                              activeQuestion: activeQuestion,
                              optionType: 'E'),
                          const SizedBox(height: 30),
                          SizedBox(
                            child: activeQuestionindex < questions.length - 1
                                ? Container()
                                : InkWell(
                                    onTap: () {
                                      List<String> questionIds = state
                                          .questionAnswers
                                          .map((e) => e.questionId)
                                          .toList();

                                      List<String> answers = state
                                          .questionAnswers
                                          .map((e) => e.answer)
                                          .toList();

                                      context.read<QuestionBloc>().add(
                                            SubmitAnswerEvent(
                                              request: SubmitAnswerRequestModel(
                                                  userEmail: context
                                                          .read<AuthBloc>()
                                                          .getCurrentSignedInEmail() ??
                                                      '',
                                                  exerciseId: exerciseId,
                                                  questionIds: questionIds,
                                                  answers: answers),
                                            ),
                                          );
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ResultScreen(),
                                          ));
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: HexColor.blue_,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Center(
                                        child: SubHeading(
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
}

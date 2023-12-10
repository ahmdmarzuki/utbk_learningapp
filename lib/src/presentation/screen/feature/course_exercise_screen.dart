import 'package:final_porject_edspert/src/presentation/screen/feature/widgets/exercise_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/color/colors.dart';
import '../../../utils/text/banner_text.dart';
import '../../../utils/text/heading.dart';
import '../../blocs/course_exercise/course_exercise_bloc.dart';

class CourseExerciseScreen extends StatefulWidget {
  final String courseTitle;

  const CourseExerciseScreen({super.key, required this.courseTitle});

  @override
  State<CourseExerciseScreen> createState() => _CourseExerciseScreenState();
}

class _CourseExerciseScreenState extends State<CourseExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.whiteBackground,
      appBar: AppBar(
          backgroundColor: const Color(0xFF3A7FD5),
          foregroundColor: Colors.white,
          title: BannerText(
            text: widget.courseTitle,
            color: HexColor.white,
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: BlocBuilder<CourseExerciseBloc, CourseExerciseState>(
            builder: (context, state) {
              print(state.runtimeType);
              if (state is CourseExerciseSuccess) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Heading(text: "Pilih Paket Soal", color: HexColor.black),
                      SizedBox(height: 20),
                      GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.courseExerciseList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 3 / 2,
                                  crossAxisSpacing: 14,
                                  mainAxisSpacing: 12,
                                  crossAxisCount: 2),
                          itemBuilder: ((context, index) {
                            return ExerciseCard(
                              exercise: state.courseExerciseList[index],
                            );
                          })),
                    ],
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}

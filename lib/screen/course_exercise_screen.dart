import 'package:final_porject_edspert/blocs/course_exercise/course_exercise_bloc.dart';
import 'package:final_porject_edspert/src/utils/color/colors.dart';
import 'package:final_porject_edspert/src/utils/text/banner_text.dart';
import 'package:final_porject_edspert/src/utils/text/heading.dart';
import 'package:final_porject_edspert/src/utils/text/sub_heading1.dart';
import 'package:final_porject_edspert/widgets/card_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseExerciseScreen extends StatelessWidget {
  final String courseTitle;
  const CourseExerciseScreen({super.key, required this.courseTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.whiteBackground,
      appBar: AppBar(
          backgroundColor: const Color(0xFF3A7FD5),
          foregroundColor: Colors.white,
          title: BannerText(
            text: courseTitle,
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
                            return Container(
                              decoration: BoxDecoration(
                                color: HexColor.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CardImage(
                                      image:
                                          state.courseExerciseList[index].icon,
                                      height: 42,
                                      width: 42,
                                    ),

                                    // text
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Heading(
                                            text: state
                                                .courseExerciseList[index]
                                                .exerciseTitle,
                                            color: HexColor.black),
                                        SubHeading1(
                                          text:
                                              "${state.courseExerciseList[index].jumlahDone}/${state.courseExerciseList[index].jumlahSoal}",
                                          color: HexColor.grey,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
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

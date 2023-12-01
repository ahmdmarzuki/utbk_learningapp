import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/course_exercise/course_exercise_bloc.dart';
import '../model/course/course_response.dart';
import '../screen/course_exercise_screen.dart';
import '../utils/text/heading.dart';
import '../utils/text/sub_heading1.dart';
import 'card_image.dart';

class CourseCard extends StatelessWidget {
  final CourseData course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseExerciseBloc, CourseExerciseState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context
                .read<CourseExerciseBloc>()
                .add(GetCourseExerciseEvent(courseId: course.courseId));

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CourseExerciseScreen(
                  courseTitle: course.courseName,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  // Container(
                  //   padding: EdgeInsets.all(12),
                  //   height: 53,
                  //   width: 53,
                  //   decoration: BoxDecoration(
                  //       color: HexColor.imageBackground,
                  //       borderRadius: BorderRadius.circular(8)),
                  //   child: Image.network(
                  //     course.urlCover,
                  //     errorBuilder: (context, error, stackTrace) {
                  //       return Center(
                  //           child: Text(
                  //         "No Img",
                  //         style: GoogleFonts.poppins(fontSize: 8),
                  //       ));
                  //     },
                  //   ),
                  // ),
                  CardImage(image: course.urlCover),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Heading(
                          text: course.courseName,
                          color: Colors.black,
                        ),
                        SubHeading1(
                            text: "${course.jumlahDone}/${course.jumlahMateri} "
                                "Paket Latihan Soal"),
                        const SizedBox(height: 11),
                        const LinearProgressIndicator(
                          value: 0.5,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
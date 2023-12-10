import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entity/course_entity.dart';
import '../../../blocs/course_exercise/course_exercise_bloc.dart';
import '../course_exercise_screen.dart';
import '../../../widget/text/heading.dart';
import '../../../widget/text/sub_heading1.dart';
import 'card_image.dart';

class CourseCard extends StatelessWidget {
  final CourseDataEntity course;
  // final ExerciseData exercise;

  const CourseCard({super.key, required this.course });

  @override
  Widget build(BuildContext context) {
    // final CourseExerciseBloc exercise = context.read<CourseExerciseBloc>();
    ;
    return BlocBuilder<CourseExerciseBloc, CourseExerciseState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context.read<CourseExerciseBloc>().add(GetCourseExerciseEvent(
                courseId: course.courseId));

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

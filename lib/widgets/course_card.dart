import 'package:final_porject_edspert/blocs/course/course_bloc.dart';
import 'package:final_porject_edspert/blocs/course_exercise/course_exercise_bloc.dart';
import 'package:final_porject_edspert/model/course/course_response.dart';
import 'package:final_porject_edspert/screen/course_exercise_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
                builder: (context) => const CourseExerciseScreen(),
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
                  Container(
                    padding: EdgeInsets.all(12),
                    height: 53,
                    width: 53,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8)),
                    child: Image.network(
                      course.urlCover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                            child: Text(
                          "No Img",
                          style: GoogleFonts.poppins(fontSize: 8),
                        ));
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.courseName,
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "${course.jumlahDone}/${course.jumlahMateri} "
                          "Paket Latihan Soal",
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: Colors.grey.shade700),
                        ),
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

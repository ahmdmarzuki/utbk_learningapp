import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/entity/course_entity.dart';
import 'widget/course_card.dart';

class AllCardListScreen extends StatelessWidget {
  final List<CourseDataEntity> courseList;
  // final List<ExerciseData> exerciseList;
  const AllCardListScreen(
      {super.key, required this.courseList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: const Color(0xFF3A7FD5),
        foregroundColor: Colors.white,
        title: Text(
          "Pilih Pelajaran",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView.separated(
        // physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: courseList.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          return CourseCard(
            course: courseList[index],
            
          );
        },
      ),
    );
  }
}

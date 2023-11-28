import 'package:final_porject_edspert/blocs/course/course_bloc.dart';
import 'package:final_porject_edspert/blocs/course_exercise/course_exercise_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseExerciseScreen extends StatelessWidget {
  const CourseExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CourseExerciseBloc, CourseExerciseState>(
        builder: (context, state) {
          print(state.runtimeType);
          if (state is CourseExerciseSuccess) {
            return ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 8,
                  );
                },
                itemCount: state.courseExerciseList.length,
                itemBuilder: (context, index) {
                  return Text(state.courseExerciseList[index].exerciseTitle);
                });
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

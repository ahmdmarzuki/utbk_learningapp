import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/blocs/course/course_bloc.dart';
import 'src/blocs/course_exercise/course_exercise_bloc.dart';
import 'src/presentation/screen/splashScreen.dart';
import 'src/repository/course_repo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CourseBloc(courseRepository: CourseRepository())
            ..add(GetCourseListEvent(majorName: 'IPA')),
        ),
        BlocProvider(
          create: (context) =>
              CourseExerciseBloc(courseRepository: CourseRepository()),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const SplashScreen()),
    );
  }
}

import 'package:dio/dio.dart';
import 'package:final_porject_edspert/firebase_options.dart';
import 'package:final_porject_edspert/src/data/datasource/remote/course_remote_datasource.dart';
import 'package:final_porject_edspert/src/domain/repository/course_repository.dart';
import 'package:final_porject_edspert/src/domain/usecases/courses_usecases/get_courses_usecases.dart';
import 'package:final_porject_edspert/src/domain/usecases/courses_usecases/get_exercise_by_courses_usecase.dart';
import 'package:final_porject_edspert/src/domain/usecases/courses_usecases/get_exercise_result_usecase.dart';
import 'package:final_porject_edspert/src/domain/usecases/courses_usecases/get_question_by_exercise_usecase.dart';
import 'package:final_porject_edspert/src/domain/usecases/courses_usecases/submit_exercise_answer.dart';
import 'package:final_porject_edspert/src/presentation/blocs/question_bloc/question_form_cubit/question_form_cubit.dart';
import 'package:final_porject_edspert/src/utils/color/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/data/datasource/remote/auth_remote_datasource.dart';
import 'src/data/repository/auth_repository_impl.dart';
import 'src/data/repository/course_repository_impl.dart';
import 'src/domain/usecases/auth_usecases/get_current_signed_in_email_usecase.dart';
import 'src/domain/usecases/auth_usecases/is_sign_in_with_google_usecase.dart';
import 'src/domain/usecases/auth_usecases/is_user_registered_usecase.dart';
import 'src/domain/usecases/auth_usecases/sign_in_with_google_usecase.dart';
import 'src/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'src/presentation/blocs/course/course_bloc.dart';
import 'src/presentation/blocs/course_exercise/course_exercise_bloc.dart';
import 'src/presentation/blocs/question_bloc/question_bloc.dart';
import 'src/presentation/screen/auth/splashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Course List provider
        BlocProvider(create: (context) {
          CourseRepository repo = CourseRepositoryImpl(
              remoteDatasource: CourseRemoteDatasource(client: Dio()));
          return CourseBloc(
              getCoursesUsecase: GetCoursesUsecase(repository: repo))
            ..add(GetCourseListEvent(majorName: 'IPA'));
        }),

        // Exercise List provider
        BlocProvider(create: (context) {
          CourseRepository repo = CourseRepositoryImpl(
              remoteDatasource: CourseRemoteDatasource(client: Dio()));
          return CourseExerciseBloc(
              getExercisesByCourseUsecase:
                  GetExercisesByCourseUsecase(repository: repo));
        }),

        // Question provider
        BlocProvider(create: (context) {
          CourseRepository repo = CourseRepositoryImpl(
              remoteDatasource: CourseRemoteDatasource(client: Dio()));
          return QuestionBloc(
            getQuestionByExerciseUsecase:
                GetQuestionByExerciseUsecase(repository: repo),
            submitExerciseAnswerUsecase:
                SubmitExerciseAnswerUsecase(repository: repo),
            getExercisesResultUsecase:
                GetExercisesResultUsecase(repository: repo),
          );
        }),
        BlocProvider(create: (context) => QuestionFormCubit()),

        BlocProvider(
          create: (context) => AuthBloc(
              SignInWithGoogleUsecase(
                repository: AuthRepositoryImpl(
                  remoteDatasource: AuthRemoteDatasource(client: Dio()),
                ),
              ),
              IsUserRegisteredUsecase(
                repository: AuthRepositoryImpl(
                  remoteDatasource: AuthRemoteDatasource(client: Dio()),
                ),
              ),
              IsSignedInWithGoogleUsecase(
                repository: AuthRepositoryImpl(
                  remoteDatasource: AuthRemoteDatasource(client: Dio()),
                ),
              ),
              GetCurrentSignedInEmailUsecase(
                repository: AuthRepositoryImpl(
                  remoteDatasource: AuthRemoteDatasource(client: Dio()),
                ),
              )),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        // theme: ThemeData(
        //   // colorScheme: ColorScheme.fromSeed(seedColor: HexColor.blue_),
        //   useMaterial3: true,
        // ),
        home: const SplashScreen(),
      ),
    );
  }
}

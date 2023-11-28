import 'package:final_porject_edspert/blocs/banner/banner_bloc.dart';
import 'package:final_porject_edspert/blocs/course/course_bloc.dart';
import 'package:final_porject_edspert/repository/banner_repo.dart';
import 'package:final_porject_edspert/repository/course_repo.dart';
import 'package:final_porject_edspert/screen/all_card_list_screen.dart';
import 'package:final_porject_edspert/widgets/course_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<CourseExerciseBloc>(
        //   create: (context) =>
        //       CourseExerciseBloc(courseRepository: CourseRepository())
        //         ..add(GetCourseExerciseEvent(courseId: '1')),
        // ),
        BlocProvider<BannerBloc>(
          create: (context) => BannerBloc(bannerRepository: BannerRepository())
            ..add(GetBannerListEvent()),
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F7F8),
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, Marzuki",
                style: GoogleFonts.poppins(
                    fontSize: 12, fontWeight: FontWeight.w600),
              ),
              Text(
                "Selamat Datang",
                style: GoogleFonts.poppins(
                    fontSize: 12, fontWeight: FontWeight.w400),
              )
            ],
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 34),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/edo selfie.png'),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            child: Column(
              children: [
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A7FD5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 60, left: 23),
                        child: Text(
                          "Mau kerjain\nlatihan soal\napa hari ini?",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                      Image.asset('assets/images/man_with_a_phone.png')
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pilih Pelajaran",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    BlocBuilder<CourseBloc, CourseState>(
                      builder: (context, state) {
                        if (state is CourseLoading) {}
                        if (state is CourseSuccess) {
                          return TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return AllCardListScreen(
                                        courseList: state.courseList);
                                  },
                                ),
                              );
                            },
                            child: Text(
                              "Lihat Semua",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF3A7FD5),
                              ),
                            ),
                          );
                        }
                        return Text(
                          "Lihat Semua",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF3A7FD5),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                // Course Bloc Builder
                BlocBuilder<CourseBloc, CourseState>(
                  builder: (context, state) {
                    print(state.runtimeType);
                    if (state is CourseFailed) {}
                    if (state is CourseSuccess) {
                      return ListView.separated(
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 3,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          return CourseCard(course: state.courseList[index]);
                        },
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
                const SizedBox(height: 28),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Terbaru",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    BlocBuilder<BannerBloc, BannerState>(
                      builder: (context, state) {
                        if (state is BannerLoading) {}

                        if (state is BannerSucces) {
                          return SizedBox(
                            height: 146,
                            child: ListView.separated(
                              // physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 8),
                              itemCount: state.bannerList.length,
                              itemBuilder: (context, index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: SizedBox(
                                    height: 146,
                                    width: 284,
                                    child: Image.network(
                                      state.bannerList[index].eventImage,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Center(
                                            child: Text(
                                          "No Img",
                                          style:
                                              GoogleFonts.poppins(fontSize: 8),
                                        ));
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

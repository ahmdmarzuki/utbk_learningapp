import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/repository/banner_repo.dart';
import '../../../utils/color/colors.dart';
import '../../widget/text/appbar_heading.dart';
import '../../widget/text/banner_text.dart';
import '../../widget/text/heading.dart';
import '../../widget/text/sub_heading1.dart';
import '../courses_and_questions/widget/course_card.dart';
import '../../blocs/banner/banner_bloc.dart';
import '../../blocs/course/course_bloc.dart';
import '../courses_and_questions/all_card_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BannerBloc>(
          create: (context) => BannerBloc(bannerRepository: BannerRepository())
            ..add(GetBannerListEvent()),
        ),
      ],
      child: Scaffold(
        backgroundColor: HexColor.whiteBackground,
        appBar: AppBar(
          backgroundColor: HexColor.whiteBackground,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Container(
            padding: EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppbarHeading(text: "Hello, Marzuki", color: HexColor.black),
                SubHeading(text: "Selamat Datang")
              ],
            ),
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
                    color: HexColor.blue_,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(bottom: 60, left: 23),
                          child: BannerText(
                            text: "Mau kerjain\nlatihan soal\napa hari ini?",
                            color: Colors.white,
                          )),
                      Image.asset('assets/images/man_with_a_phone.png')
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Heading(text: "Pilih Pelajaran", color: HexColor.black),
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
                                        courseList: state.courseList,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: SubHeading(
                                text: "Lihat Semua",
                                color: HexColor.blue_,
                              ));
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
                    if (state is CourseFailed) {
                      return Container(
                          padding: const EdgeInsets.symmetric(vertical: 50),
                          child: const Text('Tidak ada kuis tersedia'));
                    }
                    if (state is CourseSuccess) {
                      return ListView.separated(
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 3,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          return CourseCard(
                            course: state.courseList[index],
                          );
                        },
                      );
                    }
                    return Container(
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child:
                            const Center(child: CircularProgressIndicator()));
                  },
                ),
                const SizedBox(height: 28),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<BannerBloc, BannerState>(
                      builder: (context, state) {
                        // if (state is BannerLoading) {

                        // }

                        if (state is BannerSucces) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Terbaru",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 8),
                              SizedBox(
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
                                              style: GoogleFonts.poppins(
                                                  fontSize: 8),
                                            ));
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }

                        return const SizedBox();
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

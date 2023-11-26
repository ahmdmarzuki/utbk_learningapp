import 'package:final_porject_edspert/model/banner/banner_respone.dart';
import 'package:final_porject_edspert/model/course/course_response.dart';
import 'package:final_porject_edspert/repository/banner_repo.dart';
import 'package:final_porject_edspert/repository/course_repo.dart';
import 'package:final_porject_edspert/screen/all_card_list_screen.dart';
import 'package:final_porject_edspert/widgets/course_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final courseRepository = CourseRepository();
  final bannerRepository = BannerRepository();

  List<CourseData> courseList = [];
  List<BannerData> bannerList = [];

  @override
  void initState() {
    getCourseList();
    getBannerList();
    super.initState();
  }

  void getCourseList() async {
    bannerList = await bannerRepository.getBannerList();
    setState(() {});
  }

  void getBannerList() async {
    courseList = await courseRepository.getCourseList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return AllCardListScreen(courseList: courseList);
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
                  ),
                ],
              ),
              SizedBox(
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: courseList.isNotEmpty ? 3 : 1,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    return courseList.isNotEmpty
                        ? CourseCard(course: courseList[index])
                        : Center(
                            child: Text(
                              "Not Found",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                              ),
                            ),
                          );
                  },
                ),
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
                  bannerList.isNotEmpty
                      ? SizedBox(
                          height: 146,
                          child: ListView.separated(
                            // physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 8),
                            itemCount: bannerList.length,
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: SizedBox(
                                  height: 146,
                                  width: 284,
                                  child: Image.network(
                                    bannerList[index].eventImage,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(
                                          child: Text(
                                        "No Img",
                                        style: GoogleFonts.poppins(fontSize: 8),
                                      ));
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : const CircularProgressIndicator(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

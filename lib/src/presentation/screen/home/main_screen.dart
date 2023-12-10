import 'package:final_porject_edspert/src/presentation/screen/home/home_screen.dart';
import 'package:final_porject_edspert/src/presentation/screen/home/profile_screen.dart';
import 'package:final_porject_edspert/src/utils/color/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    Widget body() {
      switch (currentindex) {
        case 0:
          return HomeScreen();
        case 1:
          return ProfileScreen();
        default:
          return HomeScreen();
      }
    }

    return Scaffold(
        floatingActionButton: FloatingButtonHome(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          selectedItemColor: HexColor.black,
          unselectedItemColor: HexColor.black,
          onTap: (value) {
            setState(() {
              currentindex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Container(
                child: Image.asset('assets/icon/home_icon.png',
                    width: currentindex == 0 ? 28 : 24),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Container(
                  child: Image.asset('assets/icon/profile_icon.png',
                      width: currentindex == 1 ? 28 : 24),
                ),
                label: 'Profile')
          ],
        ),
        body: body());
  }
}

class FloatingButtonHome extends StatelessWidget {
  const FloatingButtonHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 70,
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: HexColor.blue_,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(35)),
        child: Image.asset(
          'assets/icon/quiz_icon.png',
          width: 25,
        ),
      ),
    );
  }
}

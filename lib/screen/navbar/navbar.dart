import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:skripsi/config/config.dart';
import 'package:skripsi/screen/home/home_screen.dart';
import 'package:skripsi/screen/nilai/nilai_screen.dart';
import 'package:skripsi/screen/profile/profile_screen.dart';
import 'package:skripsi/screen/tugas/tugas_screen.dart';

import '../../controller/controller.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  // final UserModel user;

  @override
  Widget build(BuildContext context) {
    final navbarC = Get.put(NavbarController());
    SizeConfig().init(context);
    return Obx(
      () => Scaffold(
        body: IndexedStack(index: navbarC.currentIndex.value, children: [
          HomeScreen(),
          TugasScreen(),
          NilaiScrenn(),
        ]),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blue[300],
          unselectedFontSize: 12,
          selectedFontSize: 12,
          selectedLabelStyle:
              const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          currentIndex: navbarC.currentIndex.value,
          selectedItemColor: Colors.black54,
          unselectedItemColor: Colors.white,
          onTap: (value) {
            navbarC.changePage(value);
          },
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/home.svg',
                  width: 26,
                  color: navbarC.currentIndex.value == 0 ? null : Colors.white,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/tugas.svg',
                  width: 26,
                  color: navbarC.currentIndex.value == 1 ? null : Colors.white,
                ),
                label: 'Tugas'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/task.svg',
                  width: 26,
                  color: navbarC.currentIndex.value == 2 ? null : Colors.white,
                ),
                label: 'Nilai'),
          ],
        ),
      ),
    );
  }
}

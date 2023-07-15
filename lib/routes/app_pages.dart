import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:skripsi/admin/list_tugas_siswa.dart';
import 'package:skripsi/admin/soal_screen.dart';
import 'package:skripsi/routes/routes_name.dart';
import 'package:skripsi/screen/splash/splash_screen.dart';

import '../admin/admin_page.dart';
import '../screen/home/nonton_video_screen.dart';
import '../screen/login/login_screen.dart';
import '../screen/navbar/navbar.dart';
import '../screen/tugas/detail_tugas_screen.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: RoutesName.navbar,
      page: () => const Navbar(),
    ),
    GetPage(
      name: RoutesName.adminPage,
      page: () => const AdminPage(),
    ),
    GetPage(
      name: RoutesName.videoScreen,
      page: () => const NontonVideoScreen(),
    ),
    GetPage(
      name: RoutesName.soalScreen,
      page: () => const SoalScreen(),
    ),
    GetPage(
      name: RoutesName.detailSoalScrenn,
      page: () => const DetailTugasScreen(),
    ),
    GetPage(
      name: RoutesName.splashPage,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: RoutesName.loginScrenn,
      page: () => const LoginScreen(),
    ),
    // GetPage(
    //   name: RoutesName.listTugasSiswa,
    //   page: () => const ListSoalSiswa(materi: ),
    // ),
  ];
}

part of 'controller.dart';

class SpalshController extends GetxController {
  void checkToken() async {
    final myPref = await SharedPreferences.getInstance();
    final token = myPref.getString('token');
    // print(token);
    if (token != null) {
      AuthService().getUser(token).then((value) {
        if (value != null) {
          value.role == 'siswa'
              ? Get.offNamed(RoutesName.navbar, arguments: value)
              : Get.offNamed(RoutesName.adminPage);
        }
      });
    } else {
      Get.offNamed(RoutesName.loginScrenn);
    }
  }

  @override
  void onInit() {
    // print('on init');
    checkToken();
    super.onInit();
  }
}

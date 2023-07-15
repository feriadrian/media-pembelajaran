part of 'controller.dart';

class NavbarController extends GetxController {
  var currentIndex = 0.obs;

  void changePage(var index) {
    currentIndex.value = index;
  }

  UserModel user = UserModel();

  @override
  void onInit() {
    super.onInit();
    user = Get.arguments;
  }
}

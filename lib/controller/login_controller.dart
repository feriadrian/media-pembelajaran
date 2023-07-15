part of 'controller.dart';

class LoginController extends GetxController {
  var isShow = true.obs;
  var isShowRegis = true.obs;


  void onTap() {
    isShow.value = !isShow.value;
  }

  void onTapRegis() {
    isShowRegis.value = !isShowRegis.value;
  }

  var isLogin = false.obs;

  void onLogin(bool index) {
    isLogin.value = index;
  }

  TextEditingController email = TextEditingController();
  TextEditingController passWord = TextEditingController();

  final formKeyLogin = GlobalKey<FormState>();
}

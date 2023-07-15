import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi/constant/constant.dart';
import 'package:skripsi/controller/controller.dart';
import 'package:skripsi/routes/routes_name.dart';
import 'package:skripsi/service/services.dart';
import 'package:skripsi/widgets/custom_textfield.dart';
import 'package:skripsi/widgets/deafult_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  color: Colors.blue[600],
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  color: const Color(0xfff5f6f8),
                ),
              ),
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(dPadding),
                  padding: EdgeInsets.all(dPadding),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Obx(
                    () => Form(
                      key: controller.formKeyLogin,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          CustomTextfield(
                            keyboard: TextInputType.emailAddress,
                            controller: controller.email,
                            hintText: 'Email',
                            validator: (p0) {
                              if (p0 == null || p0.isEmpty) {
                                return 'Field Tidak Boleh Kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          CustomTextfield(
                            validator: (p0) {
                              if (p0 == null || p0.isEmpty) {
                                return 'Field Tidak Boleh Kosong';
                              }
                              return null;
                            },
                            controller: controller.passWord,
                            onTapPassWord: () => controller.onTap(),
                            obscureText: controller.isShow.value,
                            icon: controller.isShow.value == true
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                            hintText: 'Password',
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          DefaultButton(
                              isloading: controller.isLogin.value,
                              title: 'Login',
                              press: () async {
                                controller.onLogin(true);
                                if (controller.formKeyLogin.currentState!
                                    .validate()) {
                                  await AuthService()
                                      .signInWithEmailAndPassword(
                                          controller.email.text,
                                          controller.passWord.text)
                                      .then((value) {
                                    if (value != null) {
                                      value.role == 'siswa'
                                          ? Get.offNamed(
                                              RoutesName.navbar,
                                              arguments: value,
                                            )
                                          : Get.offNamed(
                                              RoutesName.adminPage,
                                              arguments: value,
                                            );
                                    } else {
                                      controller.onLogin(false);
                                    }
                                  });
                                }
                              },
                              isWrapper: false),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi/constant/constant.dart';
import 'package:skripsi/routes/routes_name.dart';
import 'package:skripsi/service/services.dart';
import 'package:skripsi/widgets/deafult_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(dPadding),
          child: Column(
            children: [
              const Spacer(),
              DefaultButton(
                  title: 'Logout',
                  press: () {
                    Get.defaultDialog(
                        title: 'Peringatan',
                        middleText: 'Apakah anda ingin logout',
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text('Tidak'),
                          ),
                          TextButton(
                            onPressed: () async {
                              final myPref =
                                  await SharedPreferences.getInstance();
                              await myPref.remove('token');
                              await AuthService().signOut();
                              await Get.offAllNamed(RoutesName.splashPage);
                            },
                            child: const Text(
                              'Iya',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ]);

                    // final myPref = await SharedPreferences.getInstance();
                    // await AuthService().signOut();
                    // await myPref.remove('token');
                    // await Get.offAllNamed(RoutesName.splashPage);
                  },
                  isWrapper: false),
            ],
          ),
        ),
      ),
    );
  }
}

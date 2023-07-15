import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi/controller/controller.dart';

import '../../config/config.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SpalshController());
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/STKIP_YPUP.png',
              width: getWidht(121.11),
              height: getHeight(115),
            ),
            const SizedBox(
              height: 16,
            ),
            const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:skripsi/routes/routes_name.dart';

import 'package:skripsi/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      getPages: AppPages.pages,
      initialRoute: RoutesName.splashPage,
    );
  }
}

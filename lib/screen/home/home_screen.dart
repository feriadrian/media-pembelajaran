import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi/config/config.dart';
import 'package:skripsi/constant/constant.dart';
import 'package:skripsi/models/materi_model.dart';
import 'package:skripsi/routes/routes_name.dart';
import 'package:skripsi/screen/home/widgets/materi_card.dart';
import 'package:skripsi/service/services.dart';

import '../../controller/controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NavbarController>();
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(dPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Hi, ${controller.user.name}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
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
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: getHeight(12),
              ),
              Text(
                'Ayo Mulai Belajar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                'Silahkan Pilih materi dibawah ini',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: PageView(
                  children: [
                    FutureBuilder<List<MateriModel>>(
                      future: MateriServices().getAllMateri(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error ${snapshot.error}');
                        }
                        if (snapshot.hasData) {
                          if (snapshot.data!.isNotEmpty) {
                            return SingleChildScrollView(
                              child: Column(
                                children: snapshot.data!
                                    .map(
                                      (e) => MateriCard(
                                        title: e.judulMateri!,
                                        press: () => Get.toNamed(
                                            RoutesName.videoScreen,
                                            arguments: e.linkVideo),
                                      ),
                                    )
                                    .toList(),
                              ),
                            );
                          } else {
                            return Center(
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    'assets/empty_state.svg',
                                  ),
                                  SizedBox(
                                    height: getHeight(24),
                                  ),
                                  const Text(
                                    'Opps,Belum Ada Materi',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            );
                          }
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

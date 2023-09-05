import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:skripsi/config/config.dart';
import 'package:skripsi/constant/constant.dart';
import 'package:skripsi/controller/controller.dart';
import 'package:skripsi/models/uploa_tugas_model.dart';
import 'package:skripsi/screen/home/widgets/materi_card.dart';
import 'package:skripsi/service/services.dart';

class NilaiScrenn extends StatefulWidget {
  const NilaiScrenn({super.key});

  @override
  State<NilaiScrenn> createState() => _NilaiScrennState();
}

class _NilaiScrennState extends State<NilaiScrenn> {
  @override
  Widget build(BuildContext context) {
    final navbarC = Get.find<NavbarController>();
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(dPadding),
          child: FutureBuilder<List<UploadTugasModel>>(
            future:
                TugasServices().getAllTugasForSpesificSiswa(navbarC.user.name!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isNotEmpty) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      await TugasServices()
                          .getAllTugasForSpesificSiswa(navbarC.user.name!);
                      setState(() {});
                    },
                    child: ListView(
                        children: snapshot.data!
                            .map((e) => MateriCard(
                                  title: e.nilai == 0
                                      ? "${e.materi} :Belum Diperiksa"
                                      : '${e.materi} : Nilai ${e.nilai}',
                                  press: () {},
                                ))
                            .toList()),
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/empty_state.svg',
                        ),
                        SizedBox(
                          height: getHeight(24),
                        ),
                        const Text(
                          'Opps,Nilai Masih Kosong',
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  );
                }
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

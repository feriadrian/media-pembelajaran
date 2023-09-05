import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:skripsi/admin/pdf_screen.dart';
import 'package:skripsi/config/config.dart';
import 'package:skripsi/constant/constant.dart';
import 'package:skripsi/controller/controller.dart';
import 'package:skripsi/models/uploa_tugas_model.dart';
import 'package:skripsi/screen/home/widgets/materi_card.dart';
import 'package:skripsi/service/services.dart';

class ListSoalSiswa extends StatefulWidget {
  const ListSoalSiswa({super.key, required this.materi});
  final String materi;

  @override
  State<ListSoalSiswa> createState() => _ListSoalSiswaState();
}

class _ListSoalSiswaState extends State<ListSoalSiswa> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final controller = Get.find<AdminController>();
    return Scaffold(
      appBar: AppBar(
          title: Text(
            widget.materi,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          centerTitle: true),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(dPadding),
        child: FutureBuilder<List<UploadTugasModel>>(
          future: TugasServices().getAllTugas(widget.materi),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return RefreshIndicator(
                  onRefresh: () async {
                    await TugasServices().getAllTugas(widget.materi);
                    setState(() {});
                  },
                  child: ListView(
                      children: snapshot.data!
                          .map((e) => MateriCard(
                                title: e.nilai == 0
                                    ? "${e.name} : Belum Diperiksa"
                                    : "${e.name} : Sudah Diperiksa",
                                press: () async {
                                  await controller
                                      .getPeriksaTugasForAdmin(
                                          widget.materi, e.fileName ?? '')
                                      .then((value) => Get.to(PdfView(
                                            value,
                                            data: e,
                                          )));
                                },
                              ))
                          .toList()),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/empty_state.svg',
                    ),
                    SizedBox(
                      height: getHeight(24),
                    ),
                    const Text(
                      'Opps,Belum Ada Siswa Yang',
                      style: TextStyle(fontSize: 20),
                    ),
                    const Text(
                      'Kumpul',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                );
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

/// Represents Pdf for Navigation
                                    // 

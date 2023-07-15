import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skripsi/config/config.dart';
import 'package:skripsi/constant/constant.dart';
import 'package:skripsi/controller/controller.dart';
import 'package:skripsi/models/soal_model.dart';
import 'package:skripsi/service/services.dart';
import 'package:skripsi/widgets/deafult_button.dart';

import '../../admin/soal_screen.dart';
import '../../widgets/custom_textfield.dart';

class DetailTugasScreen extends StatelessWidget {
  const DetailTugasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TugasController>();
    final navbarC = Get.find<NavbarController>();

    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Get.arguments,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<SoalModel>>(
        future: controller.getAllSoal(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    flex: 9,
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: snapshot.data!
                              .map(
                                (e) => WidgetHelper(data: e),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: FutureBuilder<bool>(
                        future: TugasServices().getSpesifikTugasSiswa(
                            Get.arguments, navbarC.user.name!),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            // log(snapshot.data.toString());
                            controller.onUpload(snapshot.data!);
                            return Form(
                              key: controller.formKey,
                              child: Obx(
                                () => Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(dPadding),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: CustomTextfield(
                                              validator: (p0) {
                                                if (p0 == null || p0.isEmpty) {
                                                  return 'Pilih File Terlebih Dahulu';
                                                }
                                                return null;
                                              },
                                              onTap: () {
                                                if (!controller
                                                    .isUpload.value) {
                                                  controller.selectFile();
                                                }
                                              },
                                              hintText: 'File.pdf',
                                              readOnly: true,
                                              controller: controller.controller,
                                            ),
                                          ),
                                          SizedBox(
                                            width: getWidht(18),
                                          ),
                                          GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.blue[600],
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                vertical: getHeight(8),
                                                horizontal: getWidht(8),
                                              ),
                                              child: SvgPicture.asset(
                                                'assets/clip.svg',
                                                color: Colors.white,
                                                height: getHeight(24),
                                                width: getWidht(24),
                                                fit: BoxFit.scaleDown,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: dPadding),
                                      child: !controller.isUpload.value
                                          ? DefaultButton(
                                              isloading:
                                                  controller.isInputTugas.value,
                                              title: 'Upload Tugas',
                                              press: () async {
                                                if (controller
                                                    .formKey.currentState!
                                                    .validate()) {
                                                  controller.onInputTugas(true);
                                                  await TugasServices()
                                                      .uploadTugas(
                                                          controller.file,
                                                          navbarC.user.name!,
                                                          Get.arguments,
                                                          navbarC.user.uid!)
                                                      .then((_) {
                                                    controller.onUpload(true);
                                                    Get.snackbar(
                                                      'Sukses',
                                                      'Berhasil Mengupload Tugas',
                                                    );
                                                  });
                                                  controller
                                                      .onInputTugas(false);
                                                  controller.resetFileName();
                                                }
                                              },
                                              isWrapper: false)
                                          : Container(
                                              height: getHeight(56),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFCDCDCD),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'Tugas Telah Diupload',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text('Soal Masih Kosong'),
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
    );
  }
}

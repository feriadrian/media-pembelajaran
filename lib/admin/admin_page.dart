import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi/admin/list_tugas_siswa.dart';
import 'package:skripsi/admin/soal_card.dart';
import 'package:skripsi/config/config.dart';
import 'package:get/get.dart';
import 'package:skripsi/models/materi_model.dart';
import 'package:skripsi/routes/routes_name.dart';
import 'package:skripsi/screen/home/widgets/materi_card.dart';

import '../controller/controller.dart';
import '../service/services.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/deafult_button.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    String generateRandomString(int length) {
      var rand = Random();
      var characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
      var codeUnits = List.generate(
        length,
        (index) => characters.codeUnitAt(rand.nextInt(characters.length)),
      );

      return String.fromCharCodes(codeUnits);
    }

    SizeConfig().init(context);
    Get.put(
      AdminController(),
    );
    return GetBuilder<AdminController>(
      builder: ((controller) {
        return Scaffold(
          appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () async {
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
                  icon: const Icon(Icons.logout),
                  color: Colors.red,
                )
              ],
              elevation: 0,
              centerTitle: true,
              title: const Text(
                'Admin Side',
                style: TextStyle(color: Colors.black),
              )),
          floatingActionButton: controller.currentIndex == 1
              ? FloatingActionButton(
                  onPressed: () => controller.addSoal(),
                  child: const Icon(Icons.add),
                )
              : null,
          body: SafeArea(
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: controller.currentIndex == 0
                        ? EdgeInsets.only(
                            left: getWidht(24),
                          )
                        : const EdgeInsets.only(left: 0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => controller.pageController.animateToPage(
                            0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                          child: Container(
                            padding: EdgeInsets.only(
                              bottom: getHeight(5),
                            ),
                            decoration: controller.currentIndex == 0
                                ? const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.blue, width: 3),
                                    ),
                                  )
                                : null,
                            margin: EdgeInsets.only(
                              top: getHeight(24),
                            ),
                            child: const Text(
                              'Tambah Materi',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: getWidht(24),
                        ),
                        GestureDetector(
                          onTap: () => controller.pageController.animateToPage(
                              1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut),
                          child: Container(
                            padding: EdgeInsets.only(
                              bottom: getHeight(5),
                            ),
                            decoration: controller.currentIndex == 1
                                ? const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.blue, width: 3),
                                    ),
                                  )
                                : null,
                            margin: EdgeInsets.only(
                              top: getHeight(24),
                            ),
                            child: const Text(
                              'Upload Tugas',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: getWidht(24),
                        ),
                        GestureDetector(
                          onTap: () => controller.pageController.animateToPage(
                              2,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut),
                          child: Container(
                            padding: EdgeInsets.only(
                              bottom: getHeight(5),
                            ),
                            decoration: controller.currentIndex == 2
                                ? const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.blue, width: 3),
                                    ),
                                  )
                                : null,
                            margin: EdgeInsets.only(
                              top: getHeight(24),
                            ),
                            child: const Text(
                              'Periksa Tugas',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: getWidht(24),
                        ),
                        GestureDetector(
                          onTap: () => controller.pageController.animateToPage(
                              3,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut),
                          child: Container(
                            padding: EdgeInsets.only(
                              bottom: getHeight(5),
                            ),
                            decoration: controller.currentIndex == 3
                                ? const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.blue, width: 3),
                                    ),
                                  )
                                : null,
                            margin: EdgeInsets.only(
                              top: getHeight(24),
                            ),
                            child: const Text(
                              'List Soal',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: getWidht(24),
                        ),
                        GestureDetector(
                          onTap: () => controller.pageController.animateToPage(
                              4,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut),
                          child: Container(
                            padding: EdgeInsets.only(
                              bottom: getHeight(5),
                            ),
                            decoration: controller.currentIndex == 4
                                ? const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.blue, width: 3),
                                    ),
                                  )
                                : null,
                            margin: EdgeInsets.only(
                              top: getHeight(24),
                            ),
                            child: const Text(
                              'Tambah User',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(getWidht(24)),
                    child: PageView(
                      controller: controller.pageController,
                      onPageChanged: (value) => controller.changePage(value),
                      children: [
                        // Tambah Materi
                        Form(
                          key: controller.formKeyTambahMateri,
                          child: Column(
                            children: [
                              CustomTextfield(
                                hintText: 'Judul Materi',
                                controller: controller.judulC,
                                validator: (p0) {
                                  if (p0 == null || p0.isEmpty) {
                                    return 'Field Tidak Boleh Kosong';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: getHeight(24),
                              ),
                              CustomTextfield(
                                controller: controller.urlC,
                                hintText: 'url',
                                validator: (p0) {
                                  if (p0 == null || p0.isEmpty) {
                                    return 'Field Tidak Boleh Kosong';
                                  }
                                  return null;
                                },
                              ),
                              const Spacer(),
                              DefaultButton(
                                isWrapper: false,
                                isloading: controller.isLoading,
                                title: 'Input',
                                press: () async {
                                  if (controller
                                      .formKeyTambahMateri.currentState!
                                      .validate()) {
                                    controller.onLoading(true);
                                    await MateriServices().createMateri(
                                        controller.judulC.text,
                                        controller.urlC.text);
                                    Get.defaultDialog(
                                        title: 'Sukses',
                                        middleText:
                                            'Berhasil Menambahkan Materi');
                                    controller.resetControllerTambahMateri();
                                  }
                                  controller.onLoading(false);
                                },
                              ),
                            ],
                          ),
                        ),
                        // Upload Tugas
                        FutureBuilder<List<MateriModel>>(
                          future: MateriServices().getAllMateri(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DropdownButton2(
                                    isExpanded: true,
                                    hint: Text(
                                      'Silahkan Pilih Materi',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    items: snapshot.data!
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e.judulMateri,
                                            child: Text(
                                              e.judulMateri!,
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    value: controller.selectedValue,
                                    onChanged: (value) {
                                      controller.onSelecValue(value!);
                                    },
                                    buttonHeight: getHeight(64),
                                    buttonWidth: double.infinity,
                                    itemHeight: getHeight(64),
                                  ),
                                  SizedBox(
                                    height: getHeight(24),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: controller.jumlahSoal,
                                      itemBuilder: (context, index) => SoalCard(
                                        hintText: 'Soal Nomor ${index + 1} ',
                                        press: () => controller.getImage(index),
                                        gambarController: controller
                                            .listGambarController[index],
                                        textController: controller
                                            .listSoalController[index],
                                      ),
                                    ),
                                  ),
                                  DefaultButton(
                                    isloading: controller.isInputSoal,
                                    isWrapper: true,
                                    lebar: getWidht(240),
                                    title: 'Input Tugas',
                                    press: () async {
                                      if (controller.selectedValue != null) {
                                        controller.onInputSoal(true);
                                        await MateriServices().uploadTugas(
                                          controller.listSoalController,
                                          controller.listFile,
                                          controller.selectedValue!,
                                        );
                                        Get.defaultDialog(
                                            title: 'Sukses',
                                            middleText:
                                                'Berhasil Menambahkan Soal');
                                        controller.resetControllerUploadTugas();
                                      } else {
                                        Get.snackbar('Gagal Menginput Soal',
                                            'Mohon Untuk Memilih Materi Terlebih Dahulu');
                                      }
                                      controller.onInputSoal(false);
                                    },
                                  )
                                ],
                              );
                            }
                            if (snapshot.hasError) {
                              return (Text('${snapshot.error}'));
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                        // Periksa Tugas
                        FutureBuilder<List<String>>(
                          future: controller.buildTitleTugas(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.isNotEmpty) {
                                return SingleChildScrollView(
                                  child: Column(
                                      children: snapshot.data!
                                          .map(
                                            (e) => MateriCard(
                                                title: e,
                                                press: () {
                                                  Get.to(() => ListSoalSiswa(
                                                        materi: e,
                                                      ));
                                                }),
                                          )
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
                                      'Opps,Belum Ada Tugas',
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
                                  child: CircularProgressIndicator());
                            }
                          },
                        ),
                        // List Soal
                        FutureBuilder<List<String>>(
                          future: controller.filterData(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.isNotEmpty) {
                                return SingleChildScrollView(
                                  child: Column(
                                      children: snapshot.data!
                                          .map(
                                            (e) => MateriCard(
                                              title: e,
                                              press: () => Get.toNamed(
                                                RoutesName.soalScreen,
                                                arguments: e,
                                              ),
                                            ),
                                          )
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
                                      'Opps,Belum Ada Soal',
                                      style: TextStyle(fontSize: 20),
                                    )
                                  ],
                                );
                              }
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        ),
                        // Tambah User
                        Form(
                          key: controller.formKeyTambahUsers,
                          child: Column(
                            children: [
                              CustomTextfield(
                                hintText: 'Nama',
                                controller: controller.nameC,
                                validator: (p0) {
                                  if (p0 == null || p0.isEmpty) {
                                    return 'Field Tidak Boleh Kosong';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: getHeight(24),
                              ),
                              CustomTextfield(
                                controller: controller.emailC,
                                hintText: 'Email',
                                validator: (p0) {
                                  if (p0 == null || p0.isEmpty) {
                                    return 'Field Tidak Boleh Kosong';
                                  }
                                  return null;
                                },
                              ),
                              const Spacer(),
                              DefaultButton(
                                  isloading: controller.isCreateUser,
                                  title: 'Register',
                                  press: () async {
                                    if (controller
                                        .formKeyTambahUsers.currentState!
                                        .validate()) {
                                      controller.onCreateUser(true);
                                      await AuthService()
                                          .registerWithEmailAndPassword(
                                            controller.nameC.text,
                                            controller.emailC.text,
                                            generateRandomString(6),
                                          )
                                          .then((value) => value == true
                                              ? Get.snackbar('Sukses',
                                                  'Berhasil Menambahkan User')
                                              : null);
                                      controller.onCreateUser(false);
                                    }
                                  },
                                  isWrapper: false),
                              SizedBox(
                                height: getHeight(24),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

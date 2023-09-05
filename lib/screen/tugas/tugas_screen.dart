import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:skripsi/constant/constant.dart';
import 'package:skripsi/controller/controller.dart';
import 'package:skripsi/routes/routes_name.dart';
import 'package:skripsi/screen/home/widgets/materi_card.dart';

import '../../config/config.dart';

class TugasScreen extends StatefulWidget {
  const TugasScreen({super.key});

  @override
  State<TugasScreen> createState() => _TugasScreenState();
}

class _TugasScreenState extends State<TugasScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Get.lazyPut(
      () => TugasController(),
    );
    return GetBuilder<TugasController>(
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(dPadding),
            child: FutureBuilder<List<String>>(
              future: controller.filterData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        await controller.filterData();
                        setState(() {});
                      },
                      child: ListView(
                        children: snapshot.data!
                            .map(
                              (e) => MateriCard(
                                title: e,
                                press: () {
                                  controller.resetFileName();
                                  Get.toNamed(RoutesName.detailSoalScrenn,
                                      arguments: e);
                                },
                              ),
                            )
                            .toList(),
                      ),
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
                            'Opps,Belum Ada Tugas',
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
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi/config/config.dart';
import 'package:skripsi/constant/constant.dart';
import 'package:skripsi/controller/controller.dart';
import 'package:skripsi/models/soal_model.dart';
import 'package:skripsi/service/services.dart';

class SoalScreen extends StatelessWidget {
  const SoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdminController>();
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('Publish Soal'),
                    Switch(
                      value: controller.isBool.value,
                      onChanged: (value) async {
                        await MateriServices()
                            .publishSoal(controller.soalModel, value);
                        controller.onPublish(value);
                      },
                    ),
                    SizedBox(
                      width: getWidht(24),
                    ),
                  ],
                ),
                FutureBuilder<List<SoalModel>>(
                  future: controller.getAllSoal(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isNotEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: snapshot.data!
                              .map(
                                (e) => WidgetHelper(data: e),
                              )
                              .toList(),
                        );
                      } else {
                        return const Center(child: Text('Soal Masih Kosong'));
                      }
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error}'),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WidgetHelper extends StatelessWidget {
  const WidgetHelper({
    Key? key,
    required this.data,
  }) : super(key: key);
  final SoalModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: dPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.soal!,
                style: const TextStyle(fontSize: 18),
              ),
              FutureBuilder(
                future: MateriServices().downloadUrl(data.imagePath ?? ''),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      return Image.network(
                        snapshot.data!,
                        height: getHeight(120),
                        width: getHeight(120),
                      );
                    } else {
                      return const SizedBox();
                    }
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
        const Divider(
          color: Colors.grey,
          thickness: 0.5,
        )
      ],
    );
  }
}

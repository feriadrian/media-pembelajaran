import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:skripsi/config/config.dart';
import 'package:skripsi/constant/constant.dart';
import 'package:skripsi/controller/controller.dart';
import 'package:skripsi/models/uploa_tugas_model.dart';
import 'package:skripsi/service/services.dart';
import 'package:skripsi/widgets/custom_textfield.dart';
import 'package:skripsi/widgets/deafult_button.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfView extends StatelessWidget {
  PdfView(this.file, {super.key, required this.data});

  final String file;
  final UploadTugasModel data;

  final GlobalKey<SfPdfViewerState> _pdfviewerkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdminController>();
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              // await controller.getSpesifikTugasBySpesificSiswaForAdmin(file);
              Get.bottomSheet(
                Container(
                  height: getHeight(300),
                  padding: EdgeInsets.all(dPadding),
                  color: Colors.white,
                  child: Form(
                    key: controller.formKeyBeriNilai,
                    child: Column(
                      children: [
                        CustomTextfield(
                          keyboard: TextInputType.number,
                          controller: controller.nilaiC,
                          hintText: 'Masukkan Nilai',
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return 'Mohon Masukkan Nilai';
                            }
                            return null;
                          },
                        ),
                        Spacer(),
                        Obx(
                          () => DefaultButton(
                              isloading: controller.isInputNilai.value,
                              title: 'Input Nilai',
                              press: () async {
                                if (controller.formKeyBeriNilai.currentState!
                                    .validate()) {
                                  controller.onInputNilai(true);
                                  await TugasServices()
                                      .beriNilai(data,
                                          int.parse(controller.nilaiC.text))
                                      .then((value) {
                                    Get.snackbar(
                                        'Sukses', 'Berhasil Meginput Nilai');
                                    controller.onInputNilai(false);
                                  });
                                }
                              },
                              isWrapper: false),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            icon: SvgPicture.asset('assets/task.svg'),
          ),
        ],
        title: Text(
          data.name!,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: SfPdfViewer.network(
        file,
        key: _pdfviewerkey,
      ),
    );
  }
}

part of 'controller.dart';

class TugasController extends GetxController {
  var isInputTugas = false.obs;

  void onInputTugas(bool value) {
    isInputTugas.value = value;
  }

  final isUpload = false.obs;

  void onUpload(bool value) {
    isUpload.value = value;
  }

  Future<List<String>> filterData() async {
    try {
      var data = await MateriServices().getSoal();
      List<String> buildTitle = [];

      for (var item in data) {
        buildTitle.add(item.materi!);
      }

      final dataAfterFilter = buildTitle.toSet().toList();

      return dataAfterFilter;
    } catch (e) {
      throw Exception(e);
    }
  }

  List<SoalModel> soalModel = [];

  Future<List<SoalModel>> getAllSoal() async {
    try {
      soalModel = await MateriServices().getSpesifikSoalByMateri(Get.arguments);
      return soalModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  TextEditingController controller = TextEditingController();
  File file = File('');

  final formKey = GlobalKey<FormState>();

  void resetFileName() {
    file = File('');
    controller = TextEditingController();
  }

  Future<File?> selectFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      file = File(result.files.single.path.toString());
      controller.text = result.names.toString();
      log(file.toString());
      return file;
    } else {
      Get.snackbar('Peringatan', 'Belum Ada File Yang Terpilih');
    }
  }

  // late PdfViewerController pdfViewerController;

  // @override
  // void onInit() {
  //   pdfViewerController = PdfViewerController();
  //   super.onInit();
  // }
}

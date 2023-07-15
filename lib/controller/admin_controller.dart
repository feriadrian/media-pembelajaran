part of 'controller.dart';

class AdminController extends GetxController {
  var currentIndex = 0;

  var jumlahSoal = 1;

  final isBool = false.obs;

  void onPublish(bool value) {
    isBool.value = value;
  }

  List<File> listFile = [File('')];

  String? selectedValue;

  void onSelecValue(String value) {
    selectedValue = value;

    update();
  }

  var isInputSoal = false;

  void onInputSoal(bool value) {
    isInputSoal = value;
    update();
  }

  var isLoading = false;

  void changePage(int currentIndex) {
    this.currentIndex = currentIndex;

    update();
  }

  void onLoading(bool value) {
    isLoading = value;

    update();
  }

  var isCreateUser = false;

  void onCreateUser(bool value) {
    isCreateUser = value;
    update();
  }

  Future getImage(int index) async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100);

    listFile[index] = File(image!.path);
    listGambarController[index].text = image.name;

    update();
  }

  void addSoal() {
    jumlahSoal++;
    addItem();
    update();
  }

  List<TextEditingController> listSoalController = [
    TextEditingController(),
  ];

  List<TextEditingController> listGambarController = [
    TextEditingController(),
  ];

  void addItem() {
    listSoalController.add(TextEditingController());
    listGambarController.add(TextEditingController());
    listFile.add(File(''));
  }

  PageController pageController = PageController();

  TextEditingController judulC = TextEditingController();
  TextEditingController urlC = TextEditingController();

  final formKeyTambahMateri = GlobalKey<FormState>();

  final formKeyTambahUsers = GlobalKey<FormState>();

  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  void resetControllerUploadTugas() {
    jumlahSoal = 1;
    listSoalController = [TextEditingController()];
    listGambarController = [TextEditingController()];
    listFile = [File('')];
  }

  void resetControllerTambahMateri() {
    judulC = TextEditingController();
    urlC = TextEditingController();
  }

  Future<List<String>> filterData() async {
    var data = await MateriServices().getSoalForAdmin();
    List<String> buildTitle = [];

    for (var item in data) {
      buildTitle.add(item.materi!);
    }

    final dataAfterFilter = buildTitle.toSet().toList();

    return dataAfterFilter;
  }

  Future<List<String>> buildTitleTugas() async {
    var data = await TugasServices().getTugasForAdmin();
    List<String> buildTitleTugas = [];

    for (var item in data) {
      buildTitleTugas.add(item.materi!);
    }

    final dataAfterFilter = buildTitleTugas.toSet().toList();

    return dataAfterFilter;
  }

  List<SoalModel> soalModel = [];

  Future<List<SoalModel>> getAllSoal() async {
    try {
      soalModel = await MateriServices().getAllSoalForAdmin(Get.arguments);
      return soalModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> getPeriksaTugasForAdmin(String materi, String filename) async {
    final data =
        await TugasServices().getPeriksaTugasForAdmin(materi, filename);
    print('1');
    return data;
  }

  TextEditingController nilaiC = TextEditingController();
  final formKeyBeriNilai = GlobalKey<FormState>();

  final isInputNilai = false.obs;

  void onInputNilai(bool value) {
    isInputNilai.value = value;
  }
}

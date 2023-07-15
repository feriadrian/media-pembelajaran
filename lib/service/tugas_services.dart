part of 'services.dart';

class TugasServices {
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static CollectionReference collectionReferenceTugas =
      firebaseFirestore.collection('tugas');
  static CollectionReference collectionReferenceTugasForAdmin =
      firebaseFirestore.collection('soals');

  Future uploadTugas(File file, String name, String materi, String uid) async {
    Timestamp createAt = Timestamp.now();
    try {
      String fileName = "$name-$materi";

      final json = UploadTugasModel(
              name: name,
              materi: materi,
              fileName: fileName,
              nilai: 0,
              createAt: createAt,
              uid: uid)
          .toJson();
      final docTugas =
          FirebaseFirestore.instance.collection('tugas').doc(fileName);
      await docTugas.set(json);
      var strorage = FirebaseStorage.instance.ref('pdf/$materi/$fileName');
      await strorage.putFile(file);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<UploadTugasModel>> getTugasForAdmin() async {
    List<UploadTugasModel> tugasModel = [];

    QuerySnapshot maps =
        await collectionReferenceTugasForAdmin.orderBy('timeStamp').get();

    for (var e in maps.docs) {
      tugasModel.add(UploadTugasModel.fromJson(e.data() as dynamic));
    }

    return tugasModel;
  }

  Future<List<UploadTugasModel>> getAllTugas(String materi) async {
    List<UploadTugasModel> uploadTugasModel = [];

    final maps = await collectionReferenceTugas
        .where("materi", isEqualTo: materi)
        .orderBy('createAt')
        .get();

    for (var e in maps.docs) {
      uploadTugasModel.add(UploadTugasModel.fromJson(e.data() as dynamic));
    }

    return uploadTugasModel;
  }

  Future<bool> getSpesifikTugasSiswa(String materi, String name) async {
    try {
      QuerySnapshot maps = await collectionReferenceTugas
          .where("materi", isEqualTo: materi)
          .where('name', isEqualTo: name)
          .get();

      if (maps.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> getPeriksaTugasForAdmin(String materi, String filename) async {
    String pdf = await FirebaseStorage.instance
        .ref('pdf/$materi/$filename')
        .getDownloadURL();
    print(pdf);
    return pdf;
  }

  Future<List<UploadTugasModel>> getAllTugasForSpesificSiswa(
      String name) async {
    List<UploadTugasModel> tugasModel = [];

    QuerySnapshot maps = await collectionReferenceTugas
        .where("name", isEqualTo: name)
        .orderBy('createAt')
        .get();

    for (var e in maps.docs) {
      tugasModel.add(UploadTugasModel.fromJson(e.data() as dynamic));
    }

    // print('1');
    return tugasModel;
  }

  Future beriNilai(UploadTugasModel tugasModel, int nilai) async {
    try {
      final json = UploadTugasModel(
        createAt: tugasModel.createAt,
        fileName: tugasModel.fileName,
        materi: tugasModel.materi,
        name: tugasModel.name,
        nilai: nilai,
        uid: tugasModel.uid,
      ).toJson();

      final docMateri = FirebaseFirestore.instance
          .collection('tugas')
          .doc(tugasModel.fileName);
      await docMateri.update(json);
    } catch (e) {
      Get.snackbar('Gagal', '$e');
    }
  }
}

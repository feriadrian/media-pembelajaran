part of 'services.dart';

class MateriServices {
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static CollectionReference collectionReferenceMateries =
      firebaseFirestore.collection('materis');
  static CollectionReference collectionReferenceSoal =
      firebaseFirestore.collection('soals');
  Future<List<MateriModel>> getAllMateri() async {
    List<MateriModel> dataMateri = [];

    QuerySnapshot maps =
        await collectionReferenceMateries.orderBy('create_at').get();

    for (var e in maps.docs) {
      dataMateri.add(MateriModel.fromJson(e.data() as dynamic));
    }

    return dataMateri;
  }

  Future<List<SoalModel>> getSoalForAdmin() async {
    List<SoalModel> soalModel = [];

    QuerySnapshot maps =
        await collectionReferenceSoal.orderBy('timeStamp').get();

    for (var e in maps.docs) {
      soalModel.add(SoalModel.fromJson(e.data() as dynamic));
    }

    return soalModel;
  }

  Future<List<SoalModel>> getSoal() async {
    List<SoalModel> soalModel = [];

    QuerySnapshot maps = await collectionReferenceSoal
        .where('ispublish', isEqualTo: true)
        .orderBy('timeStamp')
        .get();

    for (var e in maps.docs) {
      soalModel.add(SoalModel.fromJson(e.data() as dynamic));
    }

    return soalModel;
  }

  Future uploadTugas(
      List<TextEditingController> soal, List<File> image, String materi) async {
    final dateTime = Timestamp.now();

    DateTime now = DateTime.now();
    for (var i = 0; i < soal.length; i++) {
      String fileName = "$materi - $now $i";

      final json = SoalModel(
              imagePath: image[i].path.isNotEmpty ? fileName : null,
              soal: '${i + 1}.${soal[i].text}',
              materi: materi,
              isPublish: false,
              timeStamp: dateTime)
          .toJson();

      final docMateri = FirebaseFirestore.instance.collection('soals').doc();
      await docMateri.set(json);

      if (image[i].path.isNotEmpty) {
        var strorage = FirebaseStorage.instance.ref('images/$fileName');
        await strorage.putFile(image[i]);
      }
    }
  }

  Future publishSoal(List<SoalModel> soalmodel, bool isPublish) async {
    try {
      for (var data in soalmodel) {
        final json = SoalModel(
          soal: data.soal,
          uid: data.uid,
          imagePath: data.imagePath,
          materi: data.materi,
          isPublish: isPublish,
          timeStamp: data.timeStamp,
        ).toJson();

        final docMateri =
            FirebaseFirestore.instance.collection('soals').doc(data.uid);
        await docMateri.update(json);
      }
    } catch (e) {
      FirebaseException;
    }
  }

  Future createMateri(String judul, String url) async {
    try {
      final dateTime = Timestamp.now();
      final docMateri = FirebaseFirestore.instance.collection('materis').doc();
      final materi = MateriModel(
          id: docMateri.id,
          judulMateri: judul,
          linkVideo: url,
          createAt: dateTime);
      final json = materi.toJson();
      await docMateri.set(json);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String?> downloadUrl(String image) async {
    try {
      String downloadUrl =
          await FirebaseStorage.instance.ref('images/$image').getDownloadURL();
      return downloadUrl;
    } catch (e) {
      return null;
    }
  }

  Future<List<SoalModel>> getSpesifikSoalByMateri(String materi) async {
    List<SoalModel> soalModels = [];

    final maps = await collectionReferenceSoal
        .where("materi", isEqualTo: materi)
        .where("ispublish", isEqualTo: true)
        .orderBy(
          'soal',
        )
        .get();

    for (var e in maps.docs) {
      soalModels.add(SoalModel.fromJson(e.data() as dynamic)..uid = e.id);
    }

    return soalModels;
  }

  Future<List<SoalModel>> getAllSoalForAdmin(String materi) async {
    List<SoalModel> soalModels = [];

    final maps = await collectionReferenceSoal
        .where("materi", isEqualTo: materi)
        .orderBy(
          'soal',
        )
        .get();

    for (var e in maps.docs) {
      soalModels.add(SoalModel.fromJson(e.data() as dynamic)..uid = e.id);
    }

    return soalModels;
  }
}

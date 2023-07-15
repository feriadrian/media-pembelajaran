import 'package:cloud_firestore/cloud_firestore.dart';

class UploadTugasModel {
  String? name;
  String? materi;
  String? fileName;
  String? uid;
  int? nilai;
  Timestamp? createAt;

  UploadTugasModel(
      {this.name,
      this.createAt,
      this.fileName,
      this.materi,
      this.nilai,
      this.uid});

  Map<String, dynamic> toJson() => {
        'name': name,
        'materi': materi,
        'filename': fileName,
        'nilai': nilai,
        'createAt': createAt,
        'uid': uid,
      };

  UploadTugasModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    materi = json['materi'];
    fileName = json['filename'];
    nilai = json['nilai'];
    createAt = json['createAt'];
    uid = json['uid'];
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class SoalModel {
  String? uid;
  String? materi;
  String? soal;
  String? imagePath;
  bool? isPublish;
  Timestamp? timeStamp;

  SoalModel(
      {this.uid,
      this.soal,
      this.imagePath,
      this.materi,
      this.isPublish,
      this.timeStamp});

  Map<String, dynamic> toJson() => {
        'soal': soal,
        'image_path': imagePath,
        'materi': materi,
        'ispublish': isPublish,
        'timeStamp': timeStamp,
      };

  SoalModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    soal = json['soal'];
    imagePath = json['image_path'];
    materi = json['materi'];
    isPublish = json['ispublish'];
    timeStamp = json['timeStamp'];
  }
}

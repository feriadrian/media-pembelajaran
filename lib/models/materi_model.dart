import 'package:cloud_firestore/cloud_firestore.dart';

class MateriModel {
  String? id;
  String? judulMateri;
  String? linkVideo;
  Timestamp? createAt;
  MateriModel({this.id, this.judulMateri, this.linkVideo, this.createAt});

  Map<String, dynamic> toJson() => {
        'id': id,
        'judul_materi': judulMateri,
        'link_video': linkVideo,
        'create_at': createAt,
      };

  MateriModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    judulMateri = json['judul_materi'];
    linkVideo = json['link_video'];
    createAt = json['create_at'];
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name;
  String? uid;
  String? email;
  String? password;
  String? role;
  Timestamp? createAt;

  UserModel({
    this.name,
    this.uid,
    this.email,
    this.password,
    this.role,
    this.createAt,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'uid': uid,
        'password': password,
        'role': role,
        'createAt': createAt,
      };

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    uid = json['uid'];
    password = json['password'];
    role = json['role'];
    createAt = json['createAt'];
  }
}

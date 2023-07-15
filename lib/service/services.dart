import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skripsi/models/soal_model.dart';
import 'package:skripsi/models/uploa_tugas_model.dart';
import 'package:skripsi/models/user_model.dart';

import '../models/materi_model.dart';

part 'materi_services.dart';
part 'auth_services.dart';
part 'tugas_services.dart';

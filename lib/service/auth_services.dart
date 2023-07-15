part of 'services.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future setToken(String uid) async {
    final myPref = await SharedPreferences.getInstance();
    await myPref.setString('token', uid);
  }

  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static CollectionReference collectionReferenceUsers =
      firebaseFirestore.collection('users');

// create MyUser object based on User
  // UserModel? _userFromFirebaseUser(User? user) {
  //   return user != null ? UserModel(uid: user.uid) : null;
  // }

  Future<UserModel?> getUser(String uid) async {
    try {
      UserModel userModel = UserModel();

      final maps = await collectionReferenceUsers.doc(uid).get();

      final data = UserModel.fromJson(maps.data() as Map<String, dynamic>);
      userModel = data;
      return userModel;
    } catch (e) {
      return null;
    }
  }

// auth change user stream

  // Stream<UserModel?> get user {
  //   return _auth.authStateChanges().map(_userFromFirebaseUser);
  // }

//sign in anonymously
  // Future signInAnon() async {
  //   try {
  //     UserCredential result = await _auth.signInAnonymously();
  //     User? user = result.user;
  //     return _userFromFirebaseUser(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // sign in with email and password

  // Future<UserModel> getUser(String id) async {
  //   UserModel userModel = UserModel();

  //   var item = await collectionReferenceUsers.doc(id).get();

  //   final data = UserModel.fromJson(item as dynamic);
  //   userModel = data;
  //   return userModel;
  // }

  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      final userModel = await getUser(user!.uid);
      await setToken(user.uid);

      return userModel;
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Gagal', '${e.message}');
      return null;
    }
  }

  // register with email and password
  Future<bool> registerWithEmailAndPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      // create new document for the user  with uid
      await DatabaseService(uid: user?.uid).createUser(name, email, password);
      // return _userFromFirebaseUser(user);
      return true;
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Gagal', '${e.message}');
      return false;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}

class DatabaseService {
  // collection reference
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future createUser(String name, String email, String password) async {
    try {
      String role = 'siswa';
      final dateTime = Timestamp.now();
      final docUser = userCollection.doc(uid);
      final user = UserModel(
        name: name,
        email: email,
        uid: uid,
        password: password,
        createAt: dateTime,
        role: role,
      );

      final json = user.toJson();
      await docUser.set(json);
    } catch (e) {
      throw Exception(e);
    }
  }
}

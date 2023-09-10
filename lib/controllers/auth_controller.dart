import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:study_app_project/firebase_ref/references.dart';
import 'package:study_app_project/models/datetime.dart';
import 'package:study_app_project/screen/home/home_screen.dart';
import 'package:study_app_project/screen/login/login_screen.dart';
import 'package:study_app_project/services/firebase_storage_service.dart';
import 'package:study_app_project/widgets/dialogs/dialogue_widget.dart';

class AuthController extends GetxController {
  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

  late FirebaseAuth _auth;

  final _user = Rxn<User>();

  late Stream<User?> _authStateChanges;

  void initAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
      _user.value = user;
    });
    navigateIntroduction();
  }

  void signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        final authAccount = await account.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: authAccount.idToken,
          accessToken: authAccount.accessToken,
        );
        await _auth.signInWithCredential(credential);
        await saveUser(account);
        Get.put(FirebaseStorageService());
        navigateToHomePage();
      }
    } on Exception catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  User? getUser() {
    _user.value = _auth.currentUser;
    return _user.value;
  }

  void navigateIntroduction() {
    Get.offAllNamed("/introduction");
  }

  saveUser(GoogleSignInAccount account) {
    userRF.doc(account.email).set({
      "email": account.email,
      "name": account.displayName,
      "profilepic": account.photoUrl
    });

    activityRF.doc(account.email).set({
      'startDate': todaysDateFormatted(),
    });
  }

  signOut() async {
    try {
      await _auth.signOut();
      navigateToLoginPage();
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void showLoginAlertDialog() {
    Get.dialog(Dialogs.questionStartDialogue(onTap: () {
      Get.back();
      navigateToLoginPage();
    }), barrierDismissible: false);
  }

  bool isLogged() {
    return _auth.currentUser != null;
  }

  void navigateToLoginPage() {
    Get.toNamed(LoginScreen.routeName);
  }

  void navigateToHomePage() {
    Get.offAllNamed(HomeScreen.routeName);
  }
}

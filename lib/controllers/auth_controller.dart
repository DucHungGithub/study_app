import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:study_app_project/firebase_ref/references.dart';
import 'package:study_app_project/screen/home/home_screen.dart';
import 'package:study_app_project/screen/login/login_screen.dart';
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
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        final _authAccount = await account.authentication;
        final _credential = GoogleAuthProvider.credential(
          idToken: _authAccount.idToken,
          accessToken: _authAccount.accessToken,
        );
        await _auth.signInWithCredential(_credential);
        await saveUser(account);
        navigateToHomePage();
      }
    } on Exception catch (error) {
      print(error);
    }
    ;
  }

  User? getUser(){
    _user.value=_auth.currentUser;
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
  }

  signOut() async {
    try{
      await _auth.signOut();
      navigateToHomePage();

    } on FirebaseAuthException catch(e){
      print(e);
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

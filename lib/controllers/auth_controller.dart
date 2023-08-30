import 'package:get/get.dart';

class AuthController extends GetxController {
  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

  void initAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    navigateIntroduction();
  }

  void navigateIntroduction() {
    Get.offAllNamed("/introduction");
  }
}

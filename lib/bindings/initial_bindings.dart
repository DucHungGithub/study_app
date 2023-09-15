import 'package:get/get.dart';
import 'package:study_app_project/controllers/auth_controller.dart';
import 'package:study_app_project/controllers/theme_controller.dart';
import 'package:study_app_project/controllers/calenderController.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(AuthController(), permanent: true);
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app_project/bindings/initial_bindings.dart';
import 'package:study_app_project/configs/themes/app_dark_theme.dart';
import 'package:study_app_project/configs/themes/app_light_theme.dart';
import 'package:study_app_project/controllers/question_page/data_uploader_screen.dart';
import 'package:study_app_project/controllers/theme_controller.dart';
import 'package:study_app_project/firebase_options.dart';
import 'package:study_app_project/routes/app_routes.dart';
import 'package:study_app_project/screen/introduction/introduction.dart';
import 'package:study_app_project/screen/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  InitialBindings().dependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Get.find<ThemeController>().lightTheme,
      getPages: AppRoutes.routes(),
    );
  }
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(GetMaterialApp(
//     home: DataUploaderScreen(),
//   ));
// }

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app_project/bindings/initial_bindings.dart';
import 'package:study_app_project/controllers/question_page/data_uploader_screen.dart';
import 'package:study_app_project/controllers/theme_controller.dart';
import 'package:study_app_project/firebase_options.dart';
import 'package:study_app_project/routes/app_routes.dart';
import 'package:study_app_project/screen/video/video_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  InitialBindings().dependencies();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    androidProvider: AndroidProvider.debug,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Get.find<ThemeController>().lightTheme,
        getPages: AppRoutes.routes(),
      ),
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

// void main()  {
//   runApp(const GetMaterialApp(
//     home: VideoConferencePage(conferenceID: "123"),
//   ));
// }


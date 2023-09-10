import 'package:flutter/material.dart';
import 'package:study_app_project/configs/themes/app_colors.dart';
import 'package:study_app_project/controllers/auth_controller.dart';
import 'package:study_app_project/services/firebase_storage_service.dart';
import 'package:study_app_project/widgets/app_circle_button.dart';
import 'package:get/get.dart';

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: mainGradient()),
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.book_online_rounded,
                size: 65,
              ),
              const SizedBox(height: 40),
              const Text(
                "This is a learning app. You can practice by answering multiple-choice questions in a variety of fields. Click the arrow below to get started.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    color: onSurfaceTextColor,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              AppCircleButton(
                onTap: () {
                  AuthController authController = Get.find();
                  if (!authController.isLogged()) {
                    authController.showLoginAlertDialog();
                  } else {
                    Get.put(FirebaseStorageService());
                    Get.offAllNamed("/home");
                  }
                },
                child: const Icon(
                  Icons.arrow_forward,
                  size: 35,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:study_app_project/controllers/auth_controller.dart';
import 'package:study_app_project/screen/video/video_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _userController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _userController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 33.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/images/video_camera.svg',
                width: 180,
                height: 180,
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 12, right: 12),
                    height: 42,
                    width: 42,
                    decoration: const BoxDecoration(
                        color: Colors.grey, shape: BoxShape.circle),
                    child: const Icon(Icons.verified_user),
                  ),
                  Flexible(
                    child: TextField(
                      controller: _userController,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600, height: 2),
                      decoration: const InputDecoration(
                        label: Text('ID:'),
                        labelStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                        hintText: "ID conference",
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      var user = Get.find<AuthController>().getUser()!;

                      if (_userController.text != "") {
                        Get.to(VideoConferencePage(
                          conferenceID: _userController.text,
                          userId: user.email!,
                          userName: user.displayName!,
                        ));
                      } else {
                        Get.snackbar("Error", "Conference ID is empty");
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 12),
                      height: 50,
                      width: 50,
                      child: const Text(
                        "Start",
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

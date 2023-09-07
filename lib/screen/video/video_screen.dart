import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app_project/configs/themes/app_light_theme.dart';
import 'package:study_app_project/controllers/theme_controller.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

class VideoConferencePage extends StatelessWidget {
  final String conferenceID;
  final String userId;
  final String userName;

  const VideoConferencePage({
    Key? key,
    required this.conferenceID, required this.userId, required this.userName,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: Brightness.light
      ),
      child: SafeArea(
        child: ZegoUIKitPrebuiltVideoConference(
          appID: 1692333246,
          // Fill in the appID that you get from ZEGOCLOUD Admin Console.
          appSign:
              "8aeff1797e28c10fa0727e9798d849a47fe794c71079c83ce4ea78c1ed6b743d",
          // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
          userID: userId,
          userName: userName,
          conferenceID: conferenceID,
          config: ZegoUIKitPrebuiltVideoConferenceConfig(
            turnOnCameraWhenJoining: false,
            onLeave: () => Get.back(),
            avatarBuilder: (BuildContext context, Size size, ZegoUIKitUser? user,
                Map extraInfo) {
              return user != null
                  ? Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://firebasestorage.googleapis.com/v0/b/study-app-af28f.appspot.com/o/question_paper_images%2Fapp_splash_logo.png?alt=media&token=78e01b34-ffee-4b64-ade6-c2d785946759',
                          ),
                        ),
                      ),
                    )
                  : const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

class VideoConferencePage extends StatelessWidget {
  final String conferenceID;
  final String userId;
  final String userName;

  static const String routeName = '/videoscreen';

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
          appID: 1438969304,
          // Fill in the appID that you get from ZEGOCLOUD Admin Console.
          appSign:
          "f9f614a08a4dc969583ce609ca2a52d7e68f1792ae436264014cffad0f0b0d78",
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

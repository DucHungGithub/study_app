import 'package:get/get.dart';
import 'package:study_app_project/screen/introduction/introduction.dart';
import 'package:study_app_project/screen/splash/splash_screen.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(name: "/", page: () => SplashScreen()),
        GetPage(name: "/introduction", page: () => AppIntroductionScreen()),
      ];
}

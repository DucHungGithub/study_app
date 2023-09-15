import 'package:get/get.dart';
import 'package:study_app_project/controllers/habit_controller.dart';
import 'package:study_app_project/controllers/question_page/question_paper_controller.dart';
import 'package:study_app_project/controllers/question_page/questions_controller.dart';
import 'package:study_app_project/controllers/summary_controller.dart';
import 'package:study_app_project/controllers/zoom_drawer_controller.dart';
import 'package:study_app_project/screen/home/home_screen.dart';
import 'package:study_app_project/screen/introduction/introduction.dart';
import 'package:study_app_project/screen/login/login_screen.dart';
import 'package:study_app_project/screen/map/habit_tracker_screen.dart';
import 'package:study_app_project/screen/question/answer_check_screen.dart';
import 'package:study_app_project/screen/question/questions_screen.dart';
import 'package:study_app_project/screen/question/result_screen.dart';
import 'package:study_app_project/screen/question/test_overview_screen.dart';
import 'package:study_app_project/screen/splash/splash_screen.dart';
import 'package:study_app_project/screen/summary/summary_screen.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(name: "/", page: () => const SplashScreen()),
        GetPage(
            name: "/introduction", page: () => const AppIntroductionScreen()),
        GetPage(
            name: "/home",
            page: () => const HomeScreen(),
            binding: BindingsBuilder(() {
              Get.put(QuestionPaperController());
              Get.put(MyZoomDrawerController());
            })),
        GetPage(
          name: LoginScreen.routeName,
          page: () => const LoginScreen(),
        ),
        GetPage(
            name: QuestionsScreen.routeName,
            page: () => const QuestionsScreen(),
            binding: BindingsBuilder(
              () {
                Get.put<QuestionsController>(QuestionsController());
              },
            )),
        GetPage(
          name: TestOverviewScreen.routeName,
          page: () => const TestOverviewScreen(),
        ),
        GetPage(
          name: ResultScreen.routeName,
          page: () => const ResultScreen(),
          binding: BindingsBuilder(
            () {
              Get.put<HabitController>(HabitController());
            },
          ),
        ),
        GetPage(
          name: AnswerCheckScreen.routeName,
          page: () => const AnswerCheckScreen(),
        ),
        GetPage(
          name: HabitTrackerScreen.routeName,
          page: () => const HabitTrackerScreen(),
          binding: BindingsBuilder(
            () {
              Get.put<HabitController>(HabitController());
            },
          ),
        ),
        GetPage(
          name: SummaryScreen.routeName,
          page: () => const SummaryScreen(),
          binding: BindingsBuilder(
            () {
              Get.put<SummaryController>(SummaryController());
            },
          ),
        ),
      ];
}

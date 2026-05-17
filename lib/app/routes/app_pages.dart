import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/mood/bindings/mood_binding.dart';
import '../modules/mood/views/mood_view.dart';
import '../modules/training/bindings/training_binding.dart';
import '../modules/training/views/training_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MOOD,
      page: () => const MoodView(),
      binding: MoodBinding(),
    ),
    GetPage(
      name: _Paths.TRAINING,
      page: () => const TrainingView(),
      binding: TrainingBinding(),
    ),
  ];
}

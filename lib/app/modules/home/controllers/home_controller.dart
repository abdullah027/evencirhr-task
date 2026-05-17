import 'dart:async';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final selectedDate = DateTime.now().obs;
  final currentTime = DateTime.now().obs;
  final waterLogged = 0.obs;
  final showBanner = false.obs;
  Timer? _timer;
  Timer? _bannerTimer;

  @override
  void onInit() {
    super.onInit();
    // Update time every 30 seconds to refresh weather icons dynamically
    _timer = Timer.periodic(const Duration(seconds: 30), (_) {
      currentTime.value = DateTime.now();
    });
  }

  void logWater() {
    if (waterLogged.value < 2000) {
      waterLogged.value += 500;
    } else {
      waterLogged.value = 0; // Wrap around to 0 on next tap if already full
    }

    // Trigger notification banner
    showBanner.value = true;

    // Reset previous banner timer if active
    _bannerTimer?.cancel();

    // Auto-hide the banner after 3 seconds
    _bannerTimer = Timer(const Duration(seconds: 3), () {
      showBanner.value = false;
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    _bannerTimer?.cancel();
    super.onClose();
  }

  // Week of the month (e.g., 2)
  int get currentWeekNumber {
    final firstDayOfMonth = DateTime(selectedDate.value.year, selectedDate.value.month, 1);
    final diff = selectedDate.value.difference(firstDayOfMonth).inDays;
    return (diff / 7).floor() + 1;
  }

  // Total weeks in the month (e.g., 4 or 5)
  int get totalWeeksInMonth {
    final firstDayOfMonth = DateTime(selectedDate.value.year, selectedDate.value.month, 1);
    final lastDayOfMonth = DateTime(selectedDate.value.year, selectedDate.value.month + 1, 0);
    final diff = lastDayOfMonth.difference(firstDayOfMonth).inDays;
    return (diff / 7).ceil();
  }

  String get weekHeader => "Week $currentWeekNumber/$totalWeeksInMonth";

  bool get isDayTime {
    // Accessing currentTime.value makes this getter reactive when used inside Obx
    final hour = currentTime.value.hour;
    return hour >= 6 && hour < 18;
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
  }
}

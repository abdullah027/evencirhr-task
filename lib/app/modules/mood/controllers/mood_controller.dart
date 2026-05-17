import 'package:get/get.dart';
import '../../../data/models/mood_type.dart';

class MoodController extends GetxController {
  final sliderValue = 0.1.obs; // 0.0 to 1.0

  MoodType get currentMood {
    if (sliderValue.value >= 0.0 && sliderValue.value < 0.25) return MoodType.calm;
    if (sliderValue.value >= 0.25 && sliderValue.value < 0.5) return MoodType.content;
    if (sliderValue.value >= 0.5 && sliderValue.value < 0.75) return MoodType.peaceful;
    return MoodType.happy;
  }

  MoodData get moodData => MoodData.all[currentMood]!;

  void updateSliderValue(double value) {
    sliderValue.value = value.clamp(0.0, 1.0);
  }
}

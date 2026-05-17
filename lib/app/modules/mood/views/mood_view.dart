import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_bottom_bar.dart';
import '../controllers/mood_controller.dart';
import '../widgets/circular_mood_slider.dart';
import '../widgets/mood_face_widget.dart';

class MoodView extends GetView<MoodController> {
  const MoodView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.5.r,
            colors: [
              Colors.blue.withOpacity(0.08),
              AppColors.background,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildTopBar(),
              8.verticalSpace,
              _buildQuestion(),
              38.verticalSpace,
              _buildMoodSlider(),
              const Spacer(),
              _buildContinueButton(),
              20.verticalSpace,
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomBar(currentIndex: 2),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Mood",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32.sp,
            ),
          ),
          const SizedBox.shrink()
        ],
      ),
    );
  }

  Widget _buildQuestion() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Start your day",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          8.verticalSpace,
          Text(
            "How are you feeling at the Moment?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodSlider() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = min(constraints.maxWidth * 0.8, 300.0.w);
        return Column(
          children: [
            Obx(() => CircularMoodSlider(
                  size: size,
                  value: controller.sliderValue.value,
                  onChanged: controller.updateSliderValue,
                  centerChild: MoodFaceWidget(
                    mood: controller.currentMood,
                    size: size * 0.44,
                  ),
                )),
            40.verticalSpace,
            Obx(() => Text(
                  controller.moodData.label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ],
        );
      },
    );
  }

  Widget _buildContinueButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          minimumSize: Size(double.infinity, 56.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          "Continue",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

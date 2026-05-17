import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../theme/app_assets.dart';
import '../../routes/app_pages.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedLabelStyle: TextStyle(fontSize: 14.sp, color: Colors.white),
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == currentIndex) return;
        switch (index) {
          case 0:
            Get.offAllNamed(Routes.HOME);
            break;
          case 1:
            Get.offAllNamed(Routes.TRAINING);
            break;
          case 2:
            Get.offAllNamed(Routes.MOOD);
            break;
          case 3:
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppAssets.nutritionIcon,
            height: 24.h,
            width: 24.w,
            colorFilter: ColorFilter.mode(
              currentIndex == 0 ? Colors.white : const Color(0xff66667E),
              BlendMode.srcIn,
            ),
          ),
          label: "Nutrition",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppAssets.planIcon,
            height: 22.h,
            width: 22.w,
            colorFilter: ColorFilter.mode(
              currentIndex == 1 ? Colors.white : const Color(0xff66667E),
              BlendMode.srcIn,
            ),
          ),
          label: "Plan",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppAssets.moodIcon,
            height: 22.h,
            width: 22.w,
            colorFilter: ColorFilter.mode(
              currentIndex == 2 ? Colors.white : const Color(0xff66667E),
              BlendMode.srcIn,
            ),
          ),
          label: "Mood",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppAssets.profileIcon,
            height: 22.h,
            width: 22.w,
            colorFilter: ColorFilter.mode(
              currentIndex == 3 ? Colors.white : const Color(0xff66667E),
              BlendMode.srcIn,
            ),
          ),
          label: "Profile",
        ),
      ],
    );
  }
}

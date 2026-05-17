import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:muhammad_abdullah/app/core/theme/app_assets.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/calendar_modal.dart';
import '../../../core/widgets/weekly_calendar_bar.dart';
import '../../../core/widgets/custom_bottom_bar.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding:  EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpace,
              _buildTopBar(),
              24.verticalSpace,
              _buildDateAndThemeHeader(),
              16.verticalSpace,
              Obx(() => WeeklyCalendarBar(
                    selectedDate: controller.selectedDate.value,
                    onDateSelected: controller.selectDate,
                  )),
              32.verticalSpace,
              _buildSectionHeader("Workouts", trailing: _buildWorkoutsHeaderTrailing()),
              24.verticalSpace,
              _buildWorkoutCard(),
              32.verticalSpace,
              _buildSectionHeader("My Insights"),
              16.verticalSpace,
              _buildInsightsGrid(),
              20.verticalSpace,
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomBar(currentIndex: 0),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(AppAssets.bellIcon,height: 24.h,width: 24.w),
        GestureDetector(
          onTap: () {
            Get.bottomSheet(
              CalendarModal(
                initialDate: controller.selectedDate.value,
                onDateSelected: controller.selectDate,
              ),
            );
          },
          child: Row(
            children: [
              SvgPicture.asset(AppAssets.weekIcon,height: 20.h,width: 20.w),
              1.5.horizontalSpace,
              Obx(() => Text(
                    controller.weekHeader,
                    style:  TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
              4.horizontalSpace,
              SvgPicture.asset(AppAssets.arrowDownIcon,height: 6.h,width: 6.w,),
            ],
          ),
        ),
        SizedBox.shrink()
      ],
    );
  }

  Widget _buildDateAndThemeHeader() {
    return Obx(() => Text(
          "Today, ${DateFormat('d MMM yyyy').format(controller.selectedDate.value)}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ));
  }

  Widget _buildSectionHeader(String title, {Widget? trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style:  TextStyle(
            color: Colors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }

  Widget _buildWorkoutsHeaderTrailing() {
    return Obx(() {
      final isDay = controller.isDayTime;
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            isDay ? Icons.wb_sunny_outlined : Icons.nights_stay_outlined,
            color: Colors.white,
            size: 22,
          ),
          6.horizontalSpace,
           Text(
            "9°",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              height: 1.0,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildWorkoutCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 24.w,right: 24.w,top: 16.h,bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundLighter,
        borderRadius: BorderRadius.circular(8.r),
        border: Border(left: BorderSide(color: AppColors.borderColor,width: 7.w))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "December 22 - 25m - 30m",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              8.verticalSpace,
              Text(
               "Upper Body",
               style: TextStyle(
                 color: Colors.white,
                 fontSize: 24.sp,
                 fontWeight: FontWeight.bold,
               ),
                            ),
            ],
          ),
          SvgPicture.asset(AppAssets.arrowRightIcon)
        ],
      ),
    );
  }

  Widget _buildInsightsGrid() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Top Row: Calories & Weight Cards
        SizedBox(
          height: 150,
          child: Row(
            children: [
              Expanded(
                child: _buildCaloriesCard(),
              ),
              16.horizontalSpace,
              Expanded(
                child: _buildWeightCard(),
              ),
            ],
          ),
        ),
        16.verticalSpace,
        // Bottom Full-width Card: Hydration
        SizedBox(
          height: 160.h,
          child: _buildHydrationCard(),
        ),
      ],
    );
  }

  Widget _buildCaloriesCard() {
    return Container(
      padding: EdgeInsets.all(13.78.sp),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundLighter,
        borderRadius: BorderRadius.circular(6.89.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
               Text(
                "550",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
              ),
              2.horizontalSpace,
               Text(
                "Calories",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          6.verticalSpace,
           Text(
            "1950 Remaining",
            style: TextStyle(
              color: AppColors.textGreyColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500
            ),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  Text("0", style: TextStyle(color: AppColors.textGreyColor2, fontSize: 14.sp,fontWeight: FontWeight.w600)),
                  Text("2500", style: TextStyle(color: AppColors.textGreyColor2, fontSize: 14.sp,fontWeight: FontWeight.w600)),
                ],
              ),
              6.verticalSpace,
              LayoutBuilder(
                builder: (context, constraints) {
                  final maxWidth = constraints.maxWidth;
                  final progressWidth = maxWidth * (833 / 2500);
                  return Container(
                    height: 6.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.borderGreyColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 6.h,
                      width: progressWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF7BBDE2),
                            Color(0xFF69C0B1),
                            Color(0xFF60C198),

                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeightCard() {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundLighter,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
               Text(
                "75",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
              ),
              6.horizontalSpace,
               Text(
                "kg",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          6.verticalSpace,
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(5.25.sp),
                decoration:  BoxDecoration(
                  color: AppColors.greenColor, // Premium dark green circular container
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  height: 4.5.h,
                  width: 4.5.w,
                  AppAssets.tiltedArrowIcon, // Bright neon green arrow
                ),
              ),
              4.horizontalSpace,
               Text(
                "+1.6kg",
                style: TextStyle(
                  color:AppColors.textGreyColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
           Text(
            "Weight",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHydrationCard() {
    return Obx(() {
      final water = controller.waterLogged.value;
      final percentage = (water / 2000 * 100).toInt();
      final showBanner = controller.showBanner.value;

      return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.cardBackgroundLighter,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding:  EdgeInsets.all(13.78.sp),
                child: Row(
                  children: [
                    // Left Column (Text & Button)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "$percentage%",
                            style:  TextStyle(
                              color: AppColors.waterColor, // Sky blue percentage color
                              fontSize: 40.sp,
                              fontWeight: FontWeight.w600,
                              height: 1.0,
                            ),
                          ),
                          const Spacer(),
                           Text(
                            "Hydration",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          4.verticalSpace,
                          if(!showBanner)
                          GestureDetector(
                            onTap: controller.logWater,
                            behavior: HitTestBehavior.opaque,
                            child:  Text(
                              "Log Now",
                              style: TextStyle(
                                color: AppColors.textGreyColor,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Right Column (Vertical Gauge Visualizer)
                    SizedBox(
                      width: 176.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            flex:0,
                            child: SizedBox(
                              height: 124.h,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children:  [
                                  Text("2 L", style: TextStyle(color: Colors.white, fontSize: 10.sp,fontWeight: FontWeight.w600)),
                                  Text("0 L", style: TextStyle(color: Colors.white, fontSize: 10.sp,fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),
                          8.horizontalSpace,
                          Expanded(
                            flex: 0,
                            child: SizedBox(
                              height: 120.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: List.generate(9, (index) {
                                  final isBlue = index == 0 || index == 4 || index == 8;
                                  return Container(
                                    width:!isBlue ?5.w : 8.77.w,
                                    height: 4.h,
                                    decoration: BoxDecoration(
                                      color: isBlue ? AppColors.waterColor : Colors.white10,
                                      borderRadius: BorderRadius.circular(2.r),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                          8.horizontalSpace,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 1.5.h,
                                    color: Color(0xff363638),
                                  ),
                                ),
                                8.horizontalSpace,
                                Expanded(
                                  flex: 0,
                                  child: Text(
                                    "${water}ml",
                                    style:  TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Dynamic Bottom Toast Notification Banner
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: showBanner ? 42.h : 0,
              curve: Curves.easeInOut,
              child: Container(
                width: double.infinity,
                color: const Color(0xFF1B3D45), // Custom premium teal banner color
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child:  Text(
                    "500 ml added to water log",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

}

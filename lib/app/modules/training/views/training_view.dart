import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/widgets/custom_bottom_bar.dart';
import '../controllers/training_controller.dart';
import '../widgets/workout_list_item.dart';

class TrainingView extends GetView<TrainingController> {
  const TrainingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Training Calendar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            24.verticalSpace,
            Container(
              color: const Color(0xFF4855DF),
              height: 3.h,
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildWeekHeader("Week 2/8", "December 8-14", "Total: 60min"),
                  16.verticalSpace,
                  _buildDayRow("Mon", "8", isWeek1: true),
                  _buildDayRow("Tue", "9", isWeek1: true),
                  _buildDayRow("Wed", "10", isWeek1: true),
                  _buildDayRow("Thu", "11", isWeek1: true),
                  _buildDayRow("Fri", "12", isWeek1: true),
                  _buildDayRow("Sat", "13", isWeek1: true),
                  _buildDayRow("Sun", "14", isWeek1: true),
                  24.verticalSpace,
                  _buildWeekHeader("Week 2", "December 14-22", "Total: 60min"),
                  16.verticalSpace,
                  _buildDayRow("Mon", "15", isWeek1: false),
                  _buildDayRow("Tue", "16", isWeek1: false),
                  _buildDayRow("Wed", "17", isWeek1: false),
                  _buildDayRow("Thu", "18", isWeek1: false),
                  _buildDayRow("Fri", "19", isWeek1: false),
                  _buildDayRow("Sat", "20", isWeek1: false),
                  _buildDayRow("Sun", "21", isWeek1: false),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomBar(currentIndex: 1),
    );
  }

  Widget _buildWeekHeader(String weekTitle, String dateRange, String durationText) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
      decoration: const BoxDecoration(
        color: Color(0xFF121212),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            weekTitle,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          6.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateRange,
                style: TextStyle(
                  color: const Color(0xFF7A7C90),
                  fontSize: 16.sp,
                ),
              ),
              Text(
                durationText,
                style: TextStyle(
                  color: const Color(0xFF7A7C90),
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayRow(String dayName, String dayNum, {required bool isWeek1}) {
    final workoutsMap = isWeek1 ? controller.week1Workouts : controller.week2Workouts;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 40.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  dayName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                6.verticalSpace,
                Text(
                  dayNum,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Obx(() {
              final workoutId = workoutsMap[dayNum];

              return DragTarget<Map<String, String>>(
                onWillAcceptWithDetails: (details) => true,
                onAcceptWithDetails: (details) {
                  final wId = details.data['workoutId']!;
                  final fromDay = details.data['fromDay']!;
                  controller.moveWorkout(wId, fromDay, dayNum);
                },
                builder: (context, candidateData, rejectedData) {
                  final isHovered = candidateData.isNotEmpty;

                  if (workoutId != null) {
                    final workout = controller.workouts.firstWhereOrNull((w) => w.id == workoutId);
                    if (workout == null) {
                      return const SizedBox.shrink();
                    }

                    return Draggable<Map<String, String>>(
                      data: {'workoutId': workoutId, 'fromDay': dayNum},
                      feedback: Material(
                        color: Colors.transparent,
                        child: Opacity(
                          opacity: 0.85,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 80.w,
                            child: WorkoutListItem(workout: workout),
                          ),
                        ),
                      ),
                      childWhenDragging: Container(
                        height: 63.h,
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 1.h,
                          color: Colors.white,
                        ),
                      ),
                      child: WorkoutListItem(workout: workout),
                    );
                  } else {
                    return Container(
                      height: 63.h,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: isHovered ? Colors.white.withValues(alpha: 0.04) : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.r),
                        border: isHovered ? Border.all(color: const Color(0xFF5E62FF).withValues(alpha: 0.3), width: 1) : null,
                      ),
                      child: Container(
                        height: 1,
                        color: isHovered ? const Color(0xFF5E62FF) : Colors.white10,
                      ),
                    );
                  }
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

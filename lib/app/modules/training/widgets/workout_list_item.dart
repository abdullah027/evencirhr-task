import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muhammad_abdullah/app/core/theme/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/workout.dart';

class WorkoutListItem extends StatelessWidget {
  final Workout workout;

  const WorkoutListItem({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    final isArms = workout.category.toLowerCase().contains('arm');
    final badgeColor = isArms ? const Color(0xFF20B76F) : const Color(0xFF4855DF);
    final badgeBg = isArms ?  Color(0xFF20B76F).withValues(alpha: 0.17): const Color(0xFF4855DF).withValues(alpha: 0.17);

    return Container(
      margin: EdgeInsets.only(bottom: 4.h),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundLighter,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 7.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.horizontal(left: Radius.circular(8.r)),
              ),
            ),
            7.3.horizontalSpace,
            Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 24.h),
                child: Icon(
                  Icons.drag_indicator_rounded,
                  color: const Color(0xFF7A7C90),
                  size: 20.sp,
                ),
              ),
            ),
            8.horizontalSpace,
            // Workout details
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Badge
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: badgeBg,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            isArms ? AppAssets.workoutIcon : AppAssets.legWorkoutIcon,
                            height: 10.h,
                            width: 10.w,
                          ),
                          4.horizontalSpace,
                          Text(
                            workout.category,
                            style: TextStyle(
                              color: badgeColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    4.verticalSpace,
                    // Workout name
                    Text(
                      workout.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Duration
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox.shrink(),
                Padding(
                  padding: EdgeInsets.only(right: 16.w,bottom: 12.h),
                  child: Center(
                    child: Text(
                      workout.duration,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

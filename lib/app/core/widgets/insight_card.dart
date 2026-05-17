import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';

class InsightCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subValue;
  final Widget? icon;
  final Widget? content;

  const InsightCard({
    super.key,
    required this.title,
    required this.value,
    this.subValue,
    this.icon,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundLighter,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (icon != null) icon!,
            ],
          ),
          12.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style:  TextStyle(
                  color: Colors.white,
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (subValue != null)...[
                2.horizontalSpace,
                Text(
                  subValue!,
                  style: const TextStyle(
                    color: AppColors.textTertiary,
                    fontSize: 12,
                  ),
                ),
              ],

            ],
          ),
          if (content != null) ...[
            16.verticalSpace,
            content!,
          ],
        ],
      ),
    );
  }
}

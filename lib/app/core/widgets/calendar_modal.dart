import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../theme/app_colors.dart';

class CalendarModal extends StatefulWidget {
  final DateTime initialDate;
  final Function(DateTime) onDateSelected;

  const CalendarModal({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
  });

  @override
  State<CalendarModal> createState() => _CalendarModalState();
}

class _CalendarModalState extends State<CalendarModal> {
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime(widget.initialDate.year, widget.initialDate.month, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: const BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle knob at the top
          Container(
            width: 58.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: const Color(0xffA1A5B7),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          16.verticalSpace,
          // Month navigation header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
                  });
                },
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Icon(Icons.chevron_left_rounded, color: Colors.white, size: 22.sp),
                ),
              ),
              Text(
                DateFormat('MMM yyyy').format(_currentMonth),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
                  });
                },
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Icon(Icons.chevron_right_rounded, color: Colors.white, size: 22.sp),
                ),
              ),
            ],
          ),
          8.verticalSpace,
          _buildCalendarGrid(),
          16.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    // Simple calendar grid for the current month
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDay = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    final daysInMonth = lastDay.day;
    final startWeekday = firstDay.weekday; // 1 = Monday

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 19.w,
      ),
      itemCount: 7 + startWeekday - 1 + daysInMonth,
      itemBuilder: (context, index) {
        if (index < 7) {
          final weekdays = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
          return Center(
            child: Text(
              weekdays[index],
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        
        final dayIndex = index - 7 - (startWeekday - 1) + 1;
        if (dayIndex <= 0 || dayIndex > daysInMonth) {
          return const SizedBox.shrink();
        }

        final date = DateTime(_currentMonth.year, _currentMonth.month, dayIndex);
        final isSelected = date.day == widget.initialDate.day &&
            date.month == widget.initialDate.month &&
            date.year == widget.initialDate.year;

        return GestureDetector(
          onTap: () {
            widget.onDateSelected(date);
            Get.back();
          },
          child: Center(
            child: Container(
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.greenColor : Colors.transparent,
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(color: const Color(0xff20B76F), width: 2.w)
                    : null,
              ),
              alignment: Alignment.center,
              child: Text(
                dayIndex.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

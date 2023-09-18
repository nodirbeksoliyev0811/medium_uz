import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../utils/colors/app_colors.dart';

class GlobalButton extends StatelessWidget {
  const GlobalButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: 10.h),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 25.w),
          height: MediaQuery.of(context).size.width /7.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            border: Border.all(width: 1,color: AppColors.black.withOpacity(0.3)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.c01851D,
                AppColors.c02BB29,
              ],
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.white,
                fontSize: 18.sp,
                fontFamily: "Sora",
              ),
            ),
          ),
        ),
      ),
    );
  }
}

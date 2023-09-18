import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../utils/colors/app_colors.dart';

class GlobalTextField extends StatelessWidget {
  const GlobalTextField({
    Key? key,
    required this.hintText,
    required this.keyboardType,
    required this.textInputAction,
    required this.textAlign,
    this.obscureText = false,
    this.maxLine = 1,
    this.suffixIcon = "",
    required this.text,
    required this.onChanged,
    this.mask="",
    this.filter="",
  }) : super(key: key);

  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextAlign textAlign;
  final bool obscureText;
  final int maxLine;
  final String suffixIcon;
  final String text;
  final ValueChanged<String> onChanged;
  final String mask;
  final String filter;

  @override
  Widget build(BuildContext context) {
    var maskFormatter = MaskTextInputFormatter(
      mask: mask,
      filter: {"#": RegExp(filter)},
      type: MaskAutoCompletionType.lazy,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 26.w),
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.black.withOpacity(0.7),
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              fontFamily: "Sora",
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 25.w),
            decoration: BoxDecoration(
              color: AppColors.c00B140,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.c00B140.withOpacity(0.9),
                  blurRadius: 5.r,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: TextField(
              cursorColor: AppColors.c01851D,
              maxLines: maxLine,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.c1F2626,
                fontFamily: "Sora",
              ),
              textAlign: textAlign,
              textInputAction: textInputAction,
              keyboardType: keyboardType,
              inputFormatters: [maskFormatter],
              obscureText: obscureText,
              onChanged: onChanged,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                hintText: hintText,
                suffixIcon: ZoomTapAnimation(
                  onTap: () {},
                  child: SvgPicture.asset(suffixIcon),
                ),
                hintStyle: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.c1F2626.withOpacity(0.3),
                  fontFamily: "Sora",
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide(
                    width: 1,
                    color: AppColors.c00B140.withOpacity(0.4),
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide(
                    width: 1,
                    color: AppColors.c00B140,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide(
                    width: 1,
                    color: AppColors.c00B140,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide(
                    width: 1,
                    color: AppColors.textColor,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide(
                    width: 1,
                    color: AppColors.textColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

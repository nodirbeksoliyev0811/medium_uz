import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../cubits/user_data/user_data_cubit.dart';
import '../../../data/models/user/user_field_keys.dart';
import '../../../utils/colors/app_colors.dart';

class GenderSelector extends StatelessWidget {
  const GenderSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String gender =   context.watch<UserDataCubit>().state.userModel.gender;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: (){
            context.read<UserDataCubit>().updateCurrentUserField(
              fieldKey: UserFieldKeys.gender,
              value: "male",
            );
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: AppColors.c01851D,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(5.r),
              child: Row(
                children: [
                  Icon(
                    gender == "male" ? Icons.circle : Icons.male,
                    color: AppColors.c00B140,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "Male",
                    style: TextStyle(
                      color: AppColors.black,
                      fontFamily: "Sora",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: (){
            context.read<UserDataCubit>().updateCurrentUserField(
              fieldKey: UserFieldKeys.gender,
              value: "female",
            );
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: AppColors.c01851D,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  Icon(
                    gender == "female" ? Icons.circle : Icons.female,
                    color: AppColors.c00B140,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "Female",
                    style: TextStyle(
                      color: AppColors.black,
                      fontFamily: "Sora",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

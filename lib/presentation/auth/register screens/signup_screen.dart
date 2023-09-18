import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../cubits/auth/auth_cubit.dart';
import '../../../cubits/user_data/user_data_cubit.dart';
import '../../../data/models/user/user_field_keys.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/ui_utils/error_message_dialog.dart';
import '../../app_routes.dart';
import '../../widgets/global_button.dart';
import '../../widgets/global_text_fields.dart';
import '../widgets/select_gender.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  ImagePicker picker = ImagePicker();

  @override
  void initState() {
    BlocProvider.of<AuthCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(builder: (context, state) {
        if (state is AuthLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 9.5,
            ),
            Center(
              child: Text(
                "Create your account",
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontFamily: "Sora",
                ),
              ),
            ),
            SizedBox(height: 51.h),
            GlobalTextField(
              hintText: "Enter username",
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.start,
              onChanged: (v) {
                context.read<UserDataCubit>().updateCurrentUserField(
                      fieldKey: UserFieldKeys.username,
                      value: v,
                    );
              },
              text: 'Username',
            ),
            SizedBox(height: 13.h),
            GlobalTextField(
              hintText: "Enter phone number",
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.start,
              onChanged: (v) {
                context.read<UserDataCubit>().updateCurrentUserField(
                      fieldKey: UserFieldKeys.contact,
                      value: v,
                    );
              },
              text: 'Phone number',
            ),
            SizedBox(height: 13.h),
            GlobalTextField(
              hintText: "ex: jon.smith@gmail.com",
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.start,
              onChanged: (v) {
                context.read<UserDataCubit>().updateCurrentUserField(
                      fieldKey: UserFieldKeys.email,
                      value: v,
                    );
              },
              text: 'Email',
            ),
            SizedBox(height: 13.h),
            GlobalTextField(
              hintText: "Profession",
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.start,
              onChanged: (v) {
                context.read<UserDataCubit>().updateCurrentUserField(
                      fieldKey: UserFieldKeys.profession,
                      value: v,
                    );
              },
              text: 'Profession',
            ),
            SizedBox(height: 13.h),
            GlobalTextField(
              hintText: "Password",
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              textAlign: TextAlign.start,
              onChanged: (v) {
                context.read<UserDataCubit>().updateCurrentUserField(
                      fieldKey: UserFieldKeys.password,
                      value: v,
                    );
              },
              text: 'Password',
            ),
            SizedBox(height: 10.h),
            const GenderSelector(),
            SizedBox(height: 10.h),
            Center(
              child: ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.c00B140,
                ),
                onPressed: () {
                  showBottomSheetDialog();
                },
                child: Text(
                  "Select image",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Sora",
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            GlobalButton(
              title: "Register",
              onTap: () {
                if (context.read<UserDataCubit>().canRegister()) {
                  context.read<AuthCubit>().sendCodeToGmail(
                        context.read<UserDataCubit>().state.userModel.email,
                        context.read<UserDataCubit>().state.userModel.password,
                      );
                } else {
                  showErrorMessage(
                    message: "Barcha maydonlarni kiriting!",
                    context: context,
                  );
                }
              },
            ),
            SizedBox(height: 26.h),
            Row(
              children: [
                const Spacer(),
                Text(
                  "Have an account?   ",
                  style: TextStyle(
                    color: AppColors.black.withOpacity(0.7),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Sora",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      RouteNames.loginScreen,
                    );
                  },
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(
                      color: AppColors.c01851D,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Sora",
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
            SizedBox(height: 13.h),
          ],
        );
      }, listener: (context, state) {
        if (state is AuthSendCodeSuccessState) {
          Navigator.pushNamed(
            context,
            RouteNames.confirmGmail,
            arguments: context.read<UserDataCubit>().state.userModel,
          );
        }

        if (state is AuthErrorState) {
          showErrorMessage(message: state.errorText, context: context);
        }
      }),
    );
  }

  void showBottomSheetDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(24.r),
          height: 157,
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(width: 1, color: AppColors.c00B140),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.r),
              topRight: Radius.circular(32.r),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  _getFromCamera();
                  Navigator.pop(context);
                },
                leading: Icon(
                  Icons.camera_alt,
                  color: AppColors.c00B140,
                ),
                title: Text(
                  "Select from Camera",
                  style: TextStyle(
                    color: AppColors.c00B140,
                    fontFamily: "Sora",
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  _getFromGallery();
                  Navigator.pop(context);
                },
                leading: Icon(
                  Icons.photo,
                  color: AppColors.c00B140,
                ),
                title: Text(
                  "Select from Gallery",
                  style: TextStyle(
                    color: AppColors.c00B140,
                    fontFamily: "Sora",
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _getFromCamera() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (xFile != null && context.mounted) {
      context.read<UserDataCubit>().updateCurrentUserField(
            fieldKey: UserFieldKeys.avatar,
            value: xFile.path,
          );
    }
  }

  Future<void> _getFromGallery() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (xFile != null && context.mounted) {
      context.read<UserDataCubit>().updateCurrentUserField(
            fieldKey: UserFieldKeys.avatar,
            value: xFile.path,
          );
    }
  }
}

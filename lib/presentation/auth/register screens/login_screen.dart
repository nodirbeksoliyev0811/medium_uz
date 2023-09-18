import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../cubits/auth/auth_cubit.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/ui_utils/error_message_dialog.dart';
import '../../app_routes.dart';
import '../../widgets/global_button.dart';
import '../../widgets/global_text_fields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String gmail = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.c01851D,
              ),
            );
          }
          return ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 5.5,
              ),
              Center(
                child: Text(
                  "Sign in your account",
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 51.h),
              GlobalTextField(
                hintText: "ex: jon.smith@email.com",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                onChanged: (v) {
                  gmail = v;
                },
                text: 'Email',
              ),
              SizedBox(height: 13.h),
              GlobalTextField(
                hintText: "_ _ _ _ _ _ _",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                textAlign: TextAlign.start,
                onChanged: (v) {
                  password = v;
                },
                mask: "######",
                text: 'Password',
              ),
              SizedBox(height: 37.h),
              GlobalButton(
                title: ("Login"),
                onTap: () {
                  if (gmail.isNotEmpty && password.isNotEmpty) {
                    context.read<AuthCubit>().loginUser(
                          gmail: gmail,
                          password: password,
                        );
                  }
                },
              ),
              SizedBox(height: 26.h),
              Row(
                children: [
                  const Spacer(),
                  Text(
                    "Don’t have an account?  ",
                    style: TextStyle(
                      color: AppColors.black.withOpacity(0.7),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        RouteNames.registerScreen,
                      );
                    },
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(
                        color: AppColors.c01851D,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(height: 13.h),
            ],
          );
        },
        buildWhen: (previous, current) {
          return true;
        },
        listener: (context, state) {
          if (state is AuthLoggedState) {
            Navigator.pushReplacementNamed(context, RouteNames.tabBox);
          }
          if (state is AuthErrorState) {
            showErrorMessage(message: state.errorText, context: context);
          }
        },
      ),
    );
  }
}

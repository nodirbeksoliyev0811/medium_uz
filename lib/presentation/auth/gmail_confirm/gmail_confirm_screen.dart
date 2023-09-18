import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/auth/auth_cubit.dart';
import '../../../cubits/user_data/user_data_cubit.dart';
import '../../../data/models/user/user_model.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/ui_utils/error_message_dialog.dart';
import '../../app_routes.dart';
import '../../widgets/global_button.dart';
import '../../widgets/global_text_fields.dart';

class GmailConfirmScreen extends StatefulWidget {
  const GmailConfirmScreen({super.key, required this.userModel});

  final UserModel userModel;

  @override
  State<GmailConfirmScreen> createState() => _GmailConfirmScreenState();
}

class _GmailConfirmScreenState extends State<GmailConfirmScreen> {
  String code = "";

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

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GlobalTextField(
                hintText: "Enter code",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                onChanged: (v) {
                  code = v;
                },
                text: 'Code',
              ),
              GlobalButton(
                title: "Confirm",
                onTap: () {
                  context.read<AuthCubit>().confirmGmail(code);
                },
              ),
              const SizedBox(height: 50)
            ],
          );
        },
        listener: (context, state) {
          if (state is AuthConfirmCodeSuccessState) {
            context.read<AuthCubit>().registerUser(widget.userModel);
          }

          if (state is AuthLoggedState) {
            context.read<UserDataCubit>().clearData();
            Navigator.pushNamedAndRemoveUntil(
                context, RouteNames.tabBox, (c) => false);
          }

          if (state is AuthErrorState) {
            showErrorMessage(message: state.errorText, context: context);
          }
        },
      ),
    );
  }
}

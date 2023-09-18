import 'package:flutter/material.dart';
import 'package:medium_uz/utils/colors/app_colors.dart';


void showLoading({required BuildContext context}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          alignment: AlignmentDirectional.center,
          decoration: const BoxDecoration(),
          child: Align(
            child: LinearProgressIndicator(color: AppColors.c01851D),
          ),
        ),
      );
    },
  );
}

void hideLoading({required BuildContext? dialogContext}) async {
  if (dialogContext != null) Navigator.pop(dialogContext);
}

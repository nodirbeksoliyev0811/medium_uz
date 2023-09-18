import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medium_uz/utils/colors/app_colors.dart';

import '../../presentation/widgets/global_button.dart';

void showErrorMessage({
  required String message,
  required BuildContext context,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Colors.white,
      shape: Border.all(
        color: AppColors.c01851D,
        width: 2,
        strokeAlign: -5,
      ),
      // title: Text(
      //   "Error !",
      //   style: TextStyle(
      //     fontWeight: FontWeight.w800,
      //     fontFamily: "Sora",
      //     fontSize: 24,
      //     color: AppColors.cEE0000,
      //   ),
      // ),
      content: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          message,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            fontSize: 20,
            fontFamily: "Sora",
          ),
        ),
      ),
      actions: [
        GlobalButton(
          onTap: () {
            Navigator.of(context).pop();
          },
          title: "Close",
        )
      ],
    ),
  );
}

Future<void> showConfirmMessage({
  required String message,
  required BuildContext context,
}) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Colors.white,
      content: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          message,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          isDefaultAction: true,
          child: const Text("ok"),
        )
      ],
    ),
  );
}

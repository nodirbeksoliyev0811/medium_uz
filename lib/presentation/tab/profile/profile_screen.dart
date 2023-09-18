// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medium_uz/presentation/tab/homework/homework_screen.dart';
// import 'package:medium_uz/utils/colors/app_colors.dart';
//
// import '../../../cubits/auth/auth_cubit.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.c01851D,
//         title: const Text("Profile"),
//         actions: [
//           IconButton(
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: const Text(
//                       "Warning !!!",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: "Sora",
//                         fontSize: 20,
//                       ),
//                     ),
//                     shape: Border.all(
//                       width: 2,
//                       strokeAlign: -5,
//                       color: AppColors.c01851D,
//                     ),
//                     content: const Text(
//                       "Are you sure you want to log out ?",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: "Sora",
//                         fontSize: 15,
//                       ),
//                     ),
//                     actions: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pop(context); // Close the dialog
//                         },
//                         child: const Text(
//                           "Cancel",
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontFamily: "Sora",
//                           ),
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           BlocProvider.of<AuthCubit>(context).logOut();
//                         },
//                         child: const Text(
//                           "Logout",
//                           style: TextStyle(
//                             color: Colors.red,
//                             fontFamily: "Sora",
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//             icon: const Icon(Icons.logout),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../cubits/auth/auth_cubit.dart';
import '../../../cubits/profile/profile_cubit.dart';
import '../../../cubits/profile/profile_state.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/images/app_images.dart';
import '../../../utils/ui_utils/error_message_dialog.dart';
import '../../app_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.c01851D,
        title: const Text(
          "Profile",
          style: TextStyle(fontFamily: "Sora"),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        "Warning !!!",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Sora",
                          fontSize: 20,
                        ),
                      ),
                      shape: Border.all(
                        width: 2,
                        strokeAlign: -5,
                        color: AppColors.c01851D,
                      ),
                      content: const Text(
                        "Are you sure you want to log out ?",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Sora",
                          fontSize: 15,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: AppColors.passiveTextColor,
                              fontFamily: "Sora",
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            BlocProvider.of<AuthCubit>(context).logOut();
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
                          },
                          child: Text(
                            "Logout",
                            style: TextStyle(
                              color: AppColors.cEE0000,
                              fontFamily: "Sora",
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return LinearProgressIndicator(
              backgroundColor: AppColors.c02BB29,
              color: AppColors.c01851D,
            );
          }
          if (state is ProfileSuccessState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.c01851D.withOpacity(0.6),
                        blurRadius: 10,
                        spreadRadius: 5,
                        offset: const Offset(0, 5),
                      )
                    ],
                    color: AppColors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: SizedBox(
                              height: 150,
                              width: 150,
                              child: CircleAvatar(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Image.network(
                                    baseUrl +
                                        state.userModel.avatar.substring(1),
                                    width: 200,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          state.userModel.username,
                          style: TextStyle(
                            color: AppColors.black,
                            fontFamily: "Sora",
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          state.userModel.email,
                          style: TextStyle(
                            color: AppColors.passiveTextColor,
                            fontFamily: "Sora",
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "+998.${state.userModel.contact}",
                          style: TextStyle(
                            color: AppColors.black,
                            fontFamily: "Sora",
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          if (state is ProfileErrorState) {
            return Center(
              child: Column(
                children: [
                  const Spacer(),
                  Lottie.asset(
                    AppImages.error,
                    width: 150,
                    height: 150,
                  ),
                  Text(
                    state.errorText,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontFamily: "Sora",
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            );
          }
          return Center(child: Lottie.asset(AppImages.empty));
        },
        listener: (context, state) {
          if (state is ProfileErrorState) {
            showErrorMessage(message: state.errorText, context: context);
          }
        },
      ),
    );
  }
}

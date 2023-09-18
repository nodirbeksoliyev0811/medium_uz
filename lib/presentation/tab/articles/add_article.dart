// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../../cubits/add/article_add_cubit.dart';
// import '../../../cubits/web/web_cubit.dart';
// import '../../../cubits/web/web_state.dart';
// import '../../../data/models/article/article_model.dart';
// import '../../../utils/colors/app_colors.dart';
// import '../../../utils/constants/status.dart';
// import '../../../utils/constants/web_keys.dart';
// import '../../../utils/ui_utils/error_message_dialog.dart';
// import '../../widgets/global_button.dart';
// import '../../widgets/global_text_fields.dart';
//
// class AddArticleScreen extends StatefulWidget {
//   const AddArticleScreen({super.key});
//
//   @override
//   State<AddArticleScreen> createState() => _AddArticleScreenState();
// }
//
// class _AddArticleScreenState extends State<AddArticleScreen> {
//   ImagePicker picker = ImagePicker();
//
//   late WebCubit bloc;
//
//   @override
//   void initState() {
//     bloc = BlocProvider.of<WebCubit>(context);
//     super.initState();
//   }
//
//   FocusNode focusNode = FocusNode();
//   XFile? file;
//   String phone = '';
//   String title = "";
//   String description = "";
//   String hashtag = "";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: AppColors.c01851D,
//         title: const Text(
//           "Add Article ",
//           style: TextStyle(
//             fontFamily: "Sora",
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: BlocConsumer<WebCubit, WebsiteState>(
//           buildWhen: (current, previous) {
//             return previous != current;
//           },
//           listener: (context, state) {
//             if (state.status == FormStatus.failure) {
//               showErrorMessage(message: state.statusText, context: context);
//             }
//           },
//           builder: (context, state) {
//             return ListView(
//               children: [
//                 const SizedBox(height: 26),
//                 GlobalTextField(
//                   hintText: "Enter title",
//                   keyboardType: TextInputType.text,
//                   textInputAction: TextInputAction.done,
//                   textAlign: TextAlign.start,
//                   onChanged: (v) {
//                     title = v;
//                   },
//                   text: 'Title',
//                 ),
//                 const SizedBox(height: 13),
//                 GlobalTextField(
//                   maxLine: 7,
//                   hintText: "Text",
//                   keyboardType: TextInputType.text,
//                   textInputAction: TextInputAction.done,
//                   textAlign: TextAlign.start,
//                   onChanged: (v) {
//                     description = v;
//                   },
//                   text: 'Description',
//                 ),
//                 const SizedBox(height: 13),
//                 GlobalTextField(
//                   hintText: "Enter hashtag",
//                   keyboardType: TextInputType.text,
//                   textInputAction: TextInputAction.next,
//                   textAlign: TextAlign.start,
//                   onChanged: (v) {
//                     hashtag = v;
//                   },
//                   text: 'Hashtag',
//                 ),
//                 const SizedBox(height: 16),
//                 if (context
//                     .read<WebCubit>()
//                     .state
//                     .websiteModel
//                     .image
//                     .isNotEmpty)
//                   SizedBox(
//                     height: 200,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(26),
//                       child: Image.file(
//                         File(file!.path),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 TextButton(
//                   onPressed: () {
//                     showBottomSheetDialog();
//                   },
//                   child: Text(
//                     'Select Image',
//                     style: TextStyle(color: AppColors.c01851D),
//                   ),
//                 ),
//                 GlobalButton(
//                   onTap: () {
//                     if (file != null &&
//                         title.isNotEmpty &&
//                         description.isNotEmpty) {
//                       context.read<ArticleAddCubit>().createArticles(
//                             articleModel: ArticleModel(
//                               hashtag: hashtag,
//                               profession: 'profession',
//                               userId: 0,
//                               likes: 'likes',
//                               artId: 0,
//                               image: file!.path,
//                               description: description,
//                               views: 'views',
//                               title: title,
//                               avatar: '',
//                               addDate: DateTime.now().toString(),
//                               username: 'username',
//                             ),
//                           );
//                       Navigator.pop(context);
//                     } else {
//                       showErrorMessage(
//                         message: 'Maydonlar toliq emas',
//                         context: context,
//                       );
//                     }
//                   },
//                   title: 'Add Article',
//                 )
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   void showBottomSheetDialog() {
//     showModalBottomSheet(
//       backgroundColor: Colors.transparent,
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           padding: EdgeInsets.all(24.r),
//           height: 157,
//           decoration: BoxDecoration(
//             color: AppColors.white,
//             border: Border.all(width: 1, color: AppColors.c00B140),
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(32.r),
//               topRight: Radius.circular(32.r),
//             ),
//           ),
//           child: Column(
//             children: [
//               ListTile(
//                 onTap: () {
//                   _getFromCamera();
//                   Navigator.pop(context);
//                 },
//                 leading: Icon(
//                   Icons.camera_alt,
//                   color: AppColors.c00B140,
//                 ),
//                 title: Text(
//                   "Select from Camera",
//                   style: TextStyle(
//                     color: AppColors.c00B140,
//                     fontFamily: "Sora",
//                   ),
//                 ),
//               ),
//               ListTile(
//                 onTap: () {
//                   _getFromGallery();
//                   Navigator.pop(context);
//                 },
//                 leading: Icon(
//                   Icons.photo,
//                   color: AppColors.c00B140,
//                 ),
//                 title: Text(
//                   "Select from Gallery",
//                   style: TextStyle(
//                     color: AppColors.c00B140,
//                     fontFamily: "Sora",
//                   ),
//                 ),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> _getFromCamera() async {
//     XFile? xFile = await picker.pickImage(
//       source: ImageSource.camera,
//     );
//
//     if (xFile != null && context.mounted) {
//       // bloc.updateWebsiteField(
//       //   fieldKey: WebsiteFieldKeys.image,
//       //   value: xFile.path,
//       // );
//       file = xFile;
//       setState(() {});
//     }
//   }
//
//   Future<void> _getFromGallery() async {
//     XFile? xFile = await picker.pickImage(
//       source: ImageSource.gallery,
//     );
//     if (xFile != null && context.mounted) {
//       file = xFile;
//       setState(() {});
//       // bloc.updateWebsiteField(
//       //   fieldKey: WebsiteFieldKeys.image,
//       //   value: xFile.path,
//       // );
//     }
//   }
// }
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../../cubits/add/article_add_cubit.dart';
import '../../../cubits/add/article_add_state.dart';
import '../../../data/models/article/article_model.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/ui_utils/error_message_dialog.dart';
import '../../widgets/global_button.dart';
import '../../widgets/global_text_fields.dart';

class AddArticleScreen extends StatefulWidget {
  const AddArticleScreen({Key? key}) : super(key: key);

  @override
  State<AddArticleScreen> createState() => _AddArticleScreenState();
}

class _AddArticleScreenState extends State<AddArticleScreen> {
  ImagePicker picker = ImagePicker();

  XFile? file;

  String title = '';
  String description = '';
  String hashtag = '';

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.c01851D,
          elevation: 0,
          title: const Text('Add article'),
        ),
        body: BlocConsumer<ArticleAddCubit, ArticleAddState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 1.1,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      GlobalTextField(
                        hintText: "Enter title",
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.start,
                        onChanged: (v) {
                          title = v;
                        },
                        text: 'Title',
                      ),
                      const SizedBox(height: 13),
                      GlobalTextField(
                        hintText: "Enter hashtag",
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        textAlign: TextAlign.start,
                        onChanged: (v) {
                          hashtag = v;
                        },
                        text: 'Hashtag',
                      ),
                      const SizedBox(height: 13),
                      GlobalTextField(
                        maxLine: 4,
                        hintText: "Text",
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.start,
                        onChanged: (v) {
                          description = v;
                        },
                        text: 'Description',
                      ),
                      file != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.file(
                                File(file!.path),
                                fit: BoxFit.cover,
                                width: 120,
                                height: 120,
                              ),
                            )
                          : const SizedBox(),
                      Row(
                        children: [
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              showBottomSheetDialog();
                            },
                            child: Text("Select image",style: TextStyle(color: AppColors.c01851D)),
                          ),
                          const Spacer()
                        ],
                      ),
                      GlobalButton(
                          title: 'Add article',
                          onTap: () {
                            if (file != null &&
                                title.isNotEmpty &&
                                description.isNotEmpty) {
                              context.read<ArticleAddCubit>().createArticles(
                                    articleModel: ArticleModel(
                                        hashtag: '#$hashtag',
                                        profession: '',
                                        userId: 0,
                                        likes: 'likes',
                                        artId: 0,
                                        image: file!.path,
                                        description: description,
                                        views: 'views',
                                        title: title,
                                        avatar: '',
                                        addDate: DateTime.now().toString(),
                                        username: ''),
                                  );
                              Navigator.pop(context);
                              showErrorMessage(
                                  message: 'Article added', context: context);
                              Navigator.pop(context);
                            } else {
                              showErrorMessage(
                                  message: 'Maydonlar toliq emas',
                                  context: context);
                            }
                          })
                    ],
                  ),
                ),
              ),
            );
          },
          listener: (context, state) {
            if (state is ArticleAddSuccessCreateState) {
              showErrorMessage(message: 'Article added', context: context);
            }
          },
        ),
      ),
    );
  }

  void showBottomSheetDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 160,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
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
                  color: AppColors.c01851D,
                ),
                title: Text(
                  "Select from Camera",
                  style: TextStyle(
                    color: AppColors.c01851D,
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
                  color: AppColors.c01851D,
                ),
                title: Text(
                  "Select from Gallery",
                  style: TextStyle(
                    color: AppColors.c01851D,
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
      file = xFile;
      setState(() {});
    }
  }

  Future<void> _getFromGallery() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (xFile != null && context.mounted) {
      file = xFile;
      setState(() {});
    }
  }
}

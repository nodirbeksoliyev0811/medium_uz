import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../cubits/web/web_cubit.dart';
import '../../../cubits/web/web_state.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/constants/status.dart';
import '../../../utils/constants/web_keys.dart';
import '../../../utils/ui_utils/error_message_dialog.dart';
import '../../widgets/global_button.dart';
import '../../widgets/global_text_fields.dart';

class AddWebsiteScreen extends StatefulWidget {
  const AddWebsiteScreen({super.key});

  @override
  State<AddWebsiteScreen> createState() => _AddWebsiteScreenState();
}

class _AddWebsiteScreenState extends State<AddWebsiteScreen> {
  ImagePicker picker = ImagePicker();

  late WebCubit bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<WebCubit>(context);
    super.initState();
  }

  FocusNode focusNode = FocusNode();

  String phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.c01851D,
        title: const Text("Add Website "),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<WebCubit, WebsiteState>(
          buildWhen: (current, previous) {
            return previous != current;
          },
          listener: (context, state) {
            if (state.status == FormStatus.failure) {
              showErrorMessage(message: state.statusText, context: context);
            }
          },
          builder: (context, state) {
            return ListView(
              children: [
                const SizedBox(height: 26),
                GlobalTextField(
                  hintText: "Enter link",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.start,
                  onChanged: (v) {
                    bloc.updateWebsiteField(
                      fieldKey: WebsiteFieldKeys.link,
                      value: v,
                    );
                  },
                  text: 'Link',
                ),
                const SizedBox(height: 13),
                GlobalTextField(
                  hintText: "Enter name",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.start,
                  onChanged: (v) {
                    bloc.updateWebsiteField(
                      fieldKey: WebsiteFieldKeys.name,
                      value: v,
                    );
                  },
                  text: 'Name',
                ),
                const SizedBox(
                  height: 13,
                ),
                GlobalTextField(
                  hintText: "Enter author name",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.start,
                  onChanged: (v) {
                    bloc.updateWebsiteField(
                      fieldKey: WebsiteFieldKeys.author,
                      value: v,
                    );
                  },
                  text: 'Author',
                ),
                const SizedBox(height: 13),
                GlobalTextField(
                  hintText: "Phone",
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.start,
                  onChanged: (v) {
                    if (v.length == 12) {
                      focusNode.unfocus();
                    }
                    phone = v;
                  },
                  mask: "## ### ## ##",
                  filter: r'\d',
                  text: 'Phone',
                ),
                const SizedBox(height: 13),
                GlobalTextField(
                  hintText: "Hashtag",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.start,
                  onChanged: (v) {
                    bloc.updateWebsiteField(
                      fieldKey: WebsiteFieldKeys.hashtag,
                      value: v,
                    );
                  },
                  text: 'Hashtag',
                ),
                const SizedBox(height: 16),
                if (context
                    .read<WebCubit>()
                    .state
                    .websiteModel
                    .image
                    .isNotEmpty)
                  SizedBox(
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(26),
                      child: Image.file(
                        File(
                          context.read<WebCubit>().state.websiteModel.image,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                TextButton(
                  onPressed: () {
                    showBottomSheetDialog();
                  },
                  child: Text(
                    'Select Image',
                    style: TextStyle(color: AppColors.c01851D),
                  ),
                ),
                GlobalButton(
                  onTap: () {
                    bloc.updateWebsiteField(
                        fieldKey: WebsiteFieldKeys.contact,
                        value: phone.replaceAll(' ', ''));
                    debugPrint(bloc.state.websiteModel.contact);
                    if (bloc.state.canAddWebsite()) {
                      bloc.createWebsite();
                      bloc.updateWebsiteField(
                          fieldKey: WebsiteFieldKeys.image, value: '');
                      Navigator.pop(context);
                    } else {
                      showErrorMessage(
                          message: "Ma'lumotlar to'liq emas!!!",
                          context: context);
                    }
                  },
                  title: 'Add Website',
                )
              ],
            );
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
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.c01851D,
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
                  color: AppColors.passiveTextColor,
                ),
                title: Text(
                  "Select from Camera",
                  style: TextStyle(color: AppColors.passiveTextColor),
                ),
              ),
              ListTile(
                onTap: () {
                  _getFromGallery();
                  Navigator.pop(context);
                },
                leading: Icon(
                  Icons.photo,
                  color: AppColors.passiveTextColor,
                ),
                title: Text(
                  "Select from Gallery",
                  style: TextStyle(color: AppColors.passiveTextColor),
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
      bloc.updateWebsiteField(
        fieldKey: WebsiteFieldKeys.image,
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
      bloc.updateWebsiteField(
        fieldKey: WebsiteFieldKeys.image,
        value: xFile.path,
      );
    }
  }
}

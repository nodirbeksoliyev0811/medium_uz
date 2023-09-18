import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medium_uz/cubits/homework/homework_cubit.dart';
import 'package:medium_uz/cubits/homework/homwork_state.dart';
import 'package:medium_uz/data/models/homework/homework_model.dart';
import 'package:medium_uz/utils/colors/app_colors.dart';
import 'package:medium_uz/utils/ui_utils/error_message_dialog.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeworkCubit>(context).getAllHomework();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.c01851D,
        title: const Text("Users"),
      ),
      body: BlocConsumer<HomeworkCubit, HomeworkState>(
        builder: (context, state) {
          if (state is HomeworkSuccessState) {
            return ListView(
              children: [
                ...List.generate(state.homeworkModels.length, (index) {
                  HomeworkModel homeworkModel = state.homeworkModels[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: CachedNetworkImage(
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                          imageUrl: homeworkModel.avatarUrl,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(
                            color: Colors.black,
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    title: Text(
                      homeworkModel.username,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    subtitle: Text(
                      homeworkModel.name,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    trailing: Text(
                      homeworkModel.state,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  );
                })
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
        listener: (context, state) {
          if (state is HomeworkErrorState) {
            showErrorMessage(message: state.errorText, context: context);
          }
          if (state is HomeworkLoadingState) {
            const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

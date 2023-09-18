import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medium_uz/presentation/app_routes.dart';
import 'package:medium_uz/utils/colors/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../cubits/web/web_cubit.dart';
import '../../../cubits/web/web_state.dart';
import '../../../data/models/web/web_model.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/constants/status.dart';
import '../../../utils/ui_utils/error_message_dialog.dart';

class WebsitesScreen extends StatefulWidget {
  const WebsitesScreen({super.key});

  @override
  State<WebsitesScreen> createState() => _WebsitesScreenState();
}

class _WebsitesScreenState extends State<WebsitesScreen> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    Future.microtask(
      () => BlocProvider.of<WebCubit>(context).getWebsites(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.c01851D,
        title: const Text("Web"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.addWebsite);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: BlocConsumer<WebCubit, WebsiteState>(
        builder: (context, state) {
          return GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              childAspectRatio: 0.8,
              mainAxisSpacing: 0,
            ),
            children: [
              ...List.generate(
                state.websites.length,
                (index) {
                  WebsiteModel website = state.websites[index];

                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: ZoomTapAnimation(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteNames.detailWebScreen,
                          arguments: website.id,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.c02BB29.withOpacity(0.6),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: const Offset(0, 0),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                  imageUrl: image + website.image,
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      const Row(
                                    children: [
                                      Spacer(),
                                      Icon(Icons.image_not_supported),
                                      SizedBox(width: 5),
                                      Text("Not Found"),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Center(
                                child: Text(
                                  website.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 20,
                                    fontFamily: "Sora",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const Spacer()
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
        listener: (context, state) {
          if (state.status == FormStatus.failure) {
            showErrorMessage(
              message: state.statusText,
              context: context,
            );
          }
          if (state.statusText == "website_added") {
            BlocProvider.of<WebCubit>(context).getWebsites(context);
          }
        },
      ),
    );
  }
}

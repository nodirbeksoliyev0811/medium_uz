import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../cubits/web/web_cubit.dart';
import '../../../cubits/web/web_state.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/constants/constants.dart';

class WebDetailScreen extends StatefulWidget {
  const WebDetailScreen({super.key, required this.id});

  final int id;

  @override
  State<WebDetailScreen> createState() => _WebDetailScreenState();
}

class _WebDetailScreenState extends State<WebDetailScreen> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    Future.microtask(
      () => BlocProvider.of<WebCubit>(context).getWebsiteById(widget.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.c01851D,
        title: const Text(
          "Info",
          style: TextStyle(
            fontFamily: "Sora",
          ),
        ),
      ),
      body: BlocConsumer<WebCubit, WebsiteState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: ListView(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: image + state.websiteDetail!.image,
                    height: MediaQuery.of(context).size.height / 3,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => const Row(
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
                const SizedBox(height: 5),
                Text(
                  state.websiteDetail!.name,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 40,
                    fontFamily: "Sora",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  state.websiteDetail!.hashtag,
                  style: TextStyle(
                    color: AppColors.passiveTextColor,
                    fontSize: 14,
                    fontFamily: "Sora",
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Icon(Icons.favorite,color: Colors.red,),
                    Text(
                      state.websiteDetail!.likes,
                      style: TextStyle(
                        color: AppColors.passiveTextColor,
                        fontSize: 14,
                        fontFamily: "Sora",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  "Author: ${state.websiteDetail!.author}",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 15,
                    fontFamily: "Sora",
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "+998${state.websiteDetail!.contact}",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 14,
                    fontFamily: "Sora",
                    fontWeight: FontWeight.w400,
                  ),
                ),
                ZoomTapAnimation(
                  onTap: () {
                    launchInBrowser(
                      Uri.parse(state.websiteDetail!.link),
                    );
                  },
                  child: Text(
                    state.websiteDetail!.link,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: AppColors.c02BB29,
                      fontSize: 15,
                      fontFamily: "Sora",
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}

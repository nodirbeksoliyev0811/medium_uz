import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:medium_uz/cubits/article/article_cubit.dart';
import 'package:medium_uz/cubits/article/article_state.dart';
import 'package:medium_uz/utils/colors/app_colors.dart';
import 'package:medium_uz/utils/images/app_images.dart';
import '../../../data/models/article/article_model.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/ui_utils/error_message_dialog.dart';
import 'add_article.dart';
import 'article_detail/article_detail_screen.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  @override
  void initState() {
    BlocProvider.of<ArticleCubit>(context).getAllArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.c01851D,
        title: const Text(
          "Articles",
          style: TextStyle(fontFamily: "Sora"),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddArticleScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocConsumer<ArticleCubit, ArticleState>(
        builder: (context, state) {
          if (state is ArticleErrorState) {
            const Center(
              child: Text("Article empty !"),
            );
          }
          if (state is ArticleSuccessState) {
            return ListView(
              children: [
                ...List.generate(
                  state.articleModels.length,
                  (index) {
                    ArticleModel articleModel = state.articleModels[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.c02BB29.withOpacity(0.6),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: const Offset(0, 5))
                        ],
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.white,
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArticleDetailScreen(
                                articleModel: articleModel,
                              ),
                            ),
                          );
                        },
                        leading: SizedBox(
                          height: 60,
                          width: 57,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: "$image${articleModel.avatar}",
                              placeholder: (context, url) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 6),
                                child: CircularProgressIndicator(
                                  color: AppColors.c01851D,
                                ),
                              ),
                              errorWidget: (context, url, error) => Icon(
                                Icons.image_not_supported,
                                color: AppColors.c01851D,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          articleModel.username,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        // subtitle: Text(
                        //   articleModel.title,
                        //   style: const TextStyle(
                        //     color: Colors.black,
                        //     fontSize: 16,
                        //   ),
                        // ),
                        trailing: Text(
                          articleModel.profession,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            );
          }
          return Center(
            child: Lottie.asset(AppImages.empty, width: 250, height: 250),
          );
        },
        listener: (context, state) {
          if (state is ArticleErrorState) {
            showErrorMessage(message: state.errorText, context: context);
          }
          if (state is ArticleLoadingState) {
            Center(
              child: CircularProgressIndicator(
                color: AppColors.c01851D,
              ),
            );
          }
        },
      ),
    );
  }
}

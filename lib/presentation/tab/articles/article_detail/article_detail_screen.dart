import 'package:flutter/material.dart';
import 'package:medium_uz/data/models/article/article_model.dart';
import 'package:medium_uz/utils/colors/app_colors.dart';
import '../../../../utils/constants/constants.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({super.key, required this.articleModel});

  final ArticleModel articleModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.c01851D,
        title: const Text("Article Info"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.network("$image${articleModel.avatar}",height: 200,width: 200),
              const SizedBox(height: 20),
              Text(
                articleModel.username,
                style: TextStyle(color: AppColors.black, fontSize: 32),
              ),
              const SizedBox(height: 20),
              Text(
                articleModel.profession,
                style: TextStyle(color: AppColors.black, fontSize: 20),
              ),
              const SizedBox(height: 20),
              Text(
                articleModel.title,
                style: TextStyle(color: AppColors.black, fontSize: 20),
              ),
              const SizedBox(height: 20),
              Text(
                articleModel.description,
                style: TextStyle(color: AppColors.black, fontSize: 14),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.favorite,color: Colors.red,),
                  Text(
                    "Like: ${articleModel.likes}",
                    style: TextStyle(color: AppColors.black, fontSize: 14),
                  ),
                  const SizedBox(width: 20),
                  const Icon(Icons.visibility,color: Colors.blue,),
                  Text(
                    "View: ${articleModel.views}",
                    style: TextStyle(color: AppColors.black, fontSize: 14),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

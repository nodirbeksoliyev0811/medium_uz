import '../../data/models/article/article_model.dart';

abstract class ArticleAddState {}

class ArticleInitial extends ArticleAddState {}

class ArticleAddLoadingState extends ArticleAddState {}
class ArticleAddSuccessCreateState extends ArticleAddState {
  ArticleAddSuccessCreateState({required this.articleModels});
  List<ArticleModel> articleModels;
}

class ArticleAddSuccessState extends ArticleAddState {
  ArticleAddSuccessState({required this.articleModels});
  List<ArticleModel> articleModels;

}

class ArticleAddErrorState extends ArticleAddState {
  final String errorText;

  ArticleAddErrorState({required this.errorText});
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medium_uz/cubits/article/article_state.dart';
import 'package:medium_uz/data/models/article/article_model.dart';
import 'package:medium_uz/data/models/universal_data.dart';
import 'package:medium_uz/data/repositories/article_repository.dart';

class ArticleCubit extends Cubit<ArticleState> {
  ArticleCubit ({required this.articleRepository}) : super(ArticleInitial());

  final ArticleRepository articleRepository;

  Future<void> getAllArticles() async {
    emit(ArticleLoadingState());
    UniversalData universalData = await articleRepository.getAllArticles();
    if (universalData.error.isEmpty) {
      emit(ArticleSuccessState(articleModels: universalData.data as List<ArticleModel>));
    } else {
      emit(ArticleErrorState(errorText: universalData.error));
    }
  }
}

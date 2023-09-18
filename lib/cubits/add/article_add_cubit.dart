import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/article/article_model.dart';
import '../../data/models/universal_data.dart';
import '../../data/repositories/article_repository.dart';
import 'article_add_state.dart';

class ArticleAddCubit extends Cubit<ArticleAddState> {
  ArticleAddCubit(this.articleRepository) : super(ArticleInitial());

  final ArticleRepository articleRepository;


  createArticles({required ArticleModel articleModel}) async {
    emit(ArticleAddLoadingState());
    UniversalData universalData =
    await articleRepository.createArticle(articleModel);
    UniversalData universalData2 = await articleRepository.getAllArticles();
    if (universalData.error.isEmpty) {
      emit(ArticleAddSuccessCreateState(
          articleModels: universalData2.data as List<ArticleModel>));
    } else {
      emit(ArticleAddErrorState(errorText: universalData.error));
    }
  }
}
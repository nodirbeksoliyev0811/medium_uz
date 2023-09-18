import '../../service/service_locator.dart';
import '../models/article/article_model.dart';
import '../models/universal_data.dart';
import '../network/api_service.dart';

class ArticleRepository {

  ArticleRepository();

  Future<UniversalData> getAllArticles() async => getInt.get<ApiService>().getAllArticles();

  Future<UniversalData> createArticle(ArticleModel newArticleModel) async =>
      ApiService().addArticle(articleModel: newArticleModel);
}

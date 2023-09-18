import '../../service/service_locator.dart';
import '../models/universal_data.dart';
import '../models/web/web_model.dart';
import '../network/api_service.dart';

class WebsiteRepository {

  WebsiteRepository();

  Future<UniversalData> getWebsites() async => getInt.get<ApiService>().getWebsites();

  Future<UniversalData> getWebsiteById(int websiteId) async =>
      getInt.get<ApiService>().getWebsiteById(websiteId);

  Future<UniversalData> createWebsite(WebsiteModel newWebsite) async =>
      getInt.get<ApiService>().createWebsite(websiteModel: newWebsite);
}
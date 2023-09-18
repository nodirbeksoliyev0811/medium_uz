import 'package:medium_uz/data/models/universal_data.dart';
import 'package:medium_uz/data/network/api_service.dart';

import '../../service/service_locator.dart';

class HomeworkRepository {

  HomeworkRepository();

  Future<UniversalData> getAllHomework() async => getInt.get<ApiService>().getAllHomework();
}

import '../../service/service_locator.dart';
import '../models/universal_data.dart';
import '../network/api_service.dart';

class ProfileRepository {

  ProfileRepository();

  Future<UniversalData> getUserData() async => getInt.get<ApiService>().getProfileData();
}
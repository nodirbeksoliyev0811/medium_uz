import 'package:medium_uz/data/local/storage_repository.dart';
import 'package:medium_uz/data/models/universal_data.dart';
import 'package:medium_uz/data/models/user/user_model.dart';
import 'package:medium_uz/data/network/api_service.dart';
import 'package:medium_uz/service/service_locator.dart';

class AuthRepository {

  AuthRepository();

  Future<UniversalData> sendCodeToGmail({
    required String gmail,
    required String password,
  }) async =>
      getInt.get<ApiService>().sendCodeToGmail(
        gmail: gmail,
        password: password,
      );

  Future<UniversalData> confirmCode({required String code}) async =>
      getInt.get<ApiService>().confirmCode(code: code);

  Future<UniversalData> registerUser({required UserModel userModel}) async =>
      getInt.get<ApiService>().registerUser(userModel: userModel);

  Future<UniversalData> loginUser({
    required String gmail,
    required String password,
  }) async =>
      getInt.get<ApiService>().loginUser(
        gmail: gmail,
        password: password,
      );

  String getToken() => StorageRepository.getString("token");

  Future<bool?> deleteToken() async => StorageRepository.deleteString("token");

  Future<void> setToken(String newToken) async =>
      StorageRepository.putString("token", newToken);
}

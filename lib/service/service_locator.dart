import 'package:get_it/get_it.dart';
import 'package:medium_uz/data/network/api_service.dart';

final getInt = GetIt.instance;

void setup(){
  getInt.registerLazySingleton(() => ApiService());
}
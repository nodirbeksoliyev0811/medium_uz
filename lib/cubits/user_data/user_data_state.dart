
import 'package:medium_uz/data/models/user/user_model.dart';

class UserDataState {
  final String errorText;
  final UserModel userModel;

  UserDataState({
    required this.userModel,
    required this.errorText,
  });

  UserDataState copyWith({
    String? errorText,
    UserModel? userModel,
  }) =>
      UserDataState(
        userModel: userModel ?? this.userModel,
        errorText: errorText ?? this.errorText,
      );
}

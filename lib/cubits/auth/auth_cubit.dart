import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:medium_uz/data/models/universal_data.dart';
import 'package:medium_uz/data/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

import '../../data/models/user/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepository}) : super(AuthInitial());

  final AuthRepository authRepository;

  Future<void> checkLoggedState() async {
    await Future.delayed(const Duration(seconds: 4));
    if (authRepository.getToken().isEmpty) {
      emit(AuthUnAuthenticatedState());
    } else {
      emit(AuthLoggedState());
    }
  }

  Future<void> sendCodeToGmail(String gmail, String password) async {
    emit(AuthLoadingState());
    UniversalData universalData = await authRepository.sendCodeToGmail(
      gmail: gmail,
      password: password,
    );
    if (universalData.error.isEmpty) {
      emit(AuthSendCodeSuccessState());
    } else {
      emit(AuthErrorState(errorText: universalData.error));
    }
  }

  Future<void> confirmGmail(String code) async {
    emit(AuthLoadingState());
    UniversalData universalData = await authRepository.confirmCode(code: code);
    if (universalData.error.isEmpty) {
      emit(AuthConfirmCodeSuccessState());
    } else {
      emit(AuthErrorState(errorText: universalData.error));
    }
  }

  Future<void> registerUser(UserModel userModel) async {
    emit(AuthLoadingState());
    UniversalData universalData =
    await authRepository.registerUser(userModel: userModel);
    if (universalData.error.isEmpty) {
      debugPrint("TOKEN${universalData.data}");
      authRepository.setToken(universalData.data as String);
      emit(AuthLoggedState());
    } else {
      emit(AuthErrorState(errorText: universalData.error));
    }
  }

  Future<void> loginUser({
    required String gmail,
    required String password,
  }) async {
    emit(AuthLoadingState());
    UniversalData universalData = await authRepository.loginUser(
      gmail: gmail,
      password: password,
    );
    if (universalData.error.isEmpty) {
      debugPrint("TOKEN${universalData.data}");
      authRepository.setToken(universalData.data as String);
      emit(AuthLoggedState());
    } else {
      emit(AuthErrorState(errorText: universalData.error));
    }
  }

  Future<void> logOut() async {
    emit(AuthLoadingState());
    bool? isDeleted = await authRepository.deleteToken();
    if (isDeleted != null) {
      emit(AuthUnAuthenticatedState());
    }
  }
  updateState(){
    emit(AuthInitial());
  }

}

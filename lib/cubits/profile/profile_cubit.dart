import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medium_uz/cubits/profile/profile_state.dart';
import '../../data/models/universal_data.dart';
import '../../data/models/user/user_model.dart';
import '../../data/repositories/profile_repository.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.profileRepository}) : super(ProfileInitial()){
    getUserData();
  }

  final ProfileRepository profileRepository;

  getUserData() async {
    emit(ProfileLoadingState());
    UniversalData response = await profileRepository.getUserData();
    if (response.error.isEmpty) {
      emit(ProfileSuccessState(userModel: response.data as UserModel));
    } else {
      emit(ProfileErrorState(errorText: response.error));
    }
  }
}
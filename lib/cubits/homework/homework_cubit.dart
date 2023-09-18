import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medium_uz/cubits/homework/homwork_state.dart';
import 'package:medium_uz/data/models/homework/homework_model.dart';
import 'package:medium_uz/data/repositories/homework_repository.dart';

import '../../data/models/universal_data.dart';

class HomeworkCubit extends Cubit<HomeworkState> {
  HomeworkCubit(this.homeworkRepository) : super(HomeworkInitial());

  final HomeworkRepository homeworkRepository;



  Future<void> getAllHomework() async {
    emit(HomeworkLoadingState());
    UniversalData universalData = await homeworkRepository.getAllHomework();
    if (universalData.error.isEmpty) {
      emit(HomeworkSuccessState(homeworkModels: universalData.data as List<HomeworkModel>));
    } else {
      emit(HomeworkErrorState(errorText: universalData.error));
    }
  }
}

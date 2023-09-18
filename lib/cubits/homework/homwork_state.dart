
import 'package:medium_uz/data/models/homework/homework_model.dart';

abstract class HomeworkState {}

class HomeworkInitial extends HomeworkState {}

class HomeworkLoadingState extends HomeworkState {}

class HomeworkSuccessState extends HomeworkState {
  HomeworkSuccessState({required this.homeworkModels});
  List<HomeworkModel> homeworkModels;

}

class HomeworkErrorState extends HomeworkState {
  final String errorText;

  HomeworkErrorState({required this.errorText});
}

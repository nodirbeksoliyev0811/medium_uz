import 'package:flutter_bloc/flutter_bloc.dart';

class TabsCubit extends Cubit<int> {
  TabsCubit() : super(0);
  void changeIndex(int index){
    emit(index);
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';

class SortCubit extends Cubit<int> {
  SortCubit() : super(0);

  void changeSort(int index) => emit(index);
}

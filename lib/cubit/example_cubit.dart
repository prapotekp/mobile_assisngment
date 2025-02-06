import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'example_state.dart';

class ExampleCubit extends Cubit<ExampleState> {
  ExampleCubit() : super(const ExampleState());

  void onLoad({required int number}) {
    final numberList = List<NumberModel>.generate(
        number, (index) => NumberModel(number: fibonacci(index), index: index));

    emit(state.copyWith(numberList: numberList));
  }

  void onDelete({required int index}) {
    final numberList = state.numberList
        ?.map((e) => e.index == index ? e.copyWith(selected: true) : e)
        .toList();

    emit(state.copyWith(numberList: numberList, lastDeleted: index));
  }

  void onAdd({required int index}) {
    final numberList = state.numberList
        ?.map((e) => e.index == index ? e.copyWith(selected: false) : e)
        .toList();

    emit(state.copyWith(numberList: numberList, lastAdded: index));
  }

  int fibonacci(int n) {
    if (n <= 1) {
      return n;
    }
    return fibonacci(n - 1) + fibonacci(n - 2);
  }
}

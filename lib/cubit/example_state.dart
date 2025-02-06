part of 'example_cubit.dart';

class ExampleState extends Equatable {
  final List<NumberModel>? numberList;
  final int? lastDeleted;
  final int? lastAdded;

  const ExampleState({
    this.numberList,
    this.lastDeleted,
    this.lastAdded,
  });

  ExampleState copyWith({
    List<NumberModel>? numberList,
    int? lastDeleted,
    int? lastAdded,
  }) {
    return ExampleState(
      numberList: numberList ?? this.numberList,
      lastDeleted: lastDeleted ?? this.lastDeleted,
      lastAdded: lastAdded ?? this.lastAdded,
    );
  }

  @override
  List<Object?> get props => [numberList, lastDeleted, lastAdded];
}

class NumberModel extends Equatable {
  final int index;
  final int number;
  final bool selected;
  final bool isLastDeleted;
  final bool isLastAdded;

  const NumberModel({
    required this.index,
    required this.number,
    this.selected = false,
    this.isLastDeleted = false,
    this.isLastAdded = false,
  });

  NumberModel copyWith({
    int? index,
    int? number,
    bool? selected,
    bool isLastDeleted = false,
    bool isLastAdded = false,
  }) {
    return NumberModel(
      index: index ?? this.index,
      number: number ?? this.number,
      selected: selected ?? this.selected,
      isLastDeleted: isLastDeleted,
      isLastAdded: isLastAdded,
    );
  }

  @override
  List<Object?> get props => [
        index,
        number,
        selected,
        isLastDeleted,
        isLastAdded,
      ];
}

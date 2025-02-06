import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_assignment/cubit/example_cubit.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  late final ExampleCubit exampleCubit;
  final ScrollController _scrollController = ScrollController();
  final Map<int, IconData> iconMapping = {
    0: Icons.circle,
    1: Icons.square_outlined,
    2: Icons.close,
  };
  git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/prapotekp/mobile_assisngment.git
git push -u origin main
  @override
  void initState() {
    super.initState();
    exampleCubit = context.read<ExampleCubit>();
    exampleCubit.onLoad(number: 40);
  }

  void _scrollToHighlightedItem(int index) {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        index * 70.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void showModelBottomSheet({required int type}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              ...exampleCubit.state.numberList
                      ?.where((element) =>
                          element.number % 3 == type && element.selected)
                      .map((e) => _buildItemModal(
                          type: type, index: e.index, number: e.number))
                      .toList() ??
                  [],
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExampleCubit, ExampleState>(
        bloc: exampleCubit,
        builder: (context, counter) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Example"),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: _buildSection(),
              ),
            ),
          );
        });
  }

  Widget _buildSection() {
    return Column(
      children: [
        ...exampleCubit.state.numberList
                ?.where((element) => !element.selected)
                .toList()
                .map((e) => _buildItem(index: e.index, number: e.number))
                .toList() ??
            [],
      ],
    );
  }

  Widget _buildItem({required int index, required int number}) {
    final type = number % 3;
    final color = index == exampleCubit.state.lastAdded
        ? Colors.red.withOpacity(0.5)
        : Colors.transparent;

    return ListTile(
      minVerticalPadding: 20,
      title: Text(
        "Index: $index, Number: $number",
        style: const TextStyle(fontSize: 24),
      ),
      tileColor: color,
      trailing: Icon(
        iconMapping[type],
        size: 34,
      ),
      onTap: () {
        exampleCubit.onDelete(index: index);
        showModelBottomSheet(type: type);
      },
    );
  }

  Widget _buildItemModal(
      {required int type, required int index, required int number}) {
    final color = index == exampleCubit.state.lastDeleted
        ? Colors.green
        : Colors.transparent;

    return ListTile(
      minVerticalPadding: 20,
      title: Text(
        "Number: $number",
        style: const TextStyle(fontSize: 24),
      ),
      subtitle: Text("Index: $index"),
      tileColor: color,
      trailing: Icon(
        iconMapping[type],
        size: 34,
      ),
      onTap: () {
        exampleCubit.onAdd(index: index);
        Navigator.pop(context);
        _scrollToHighlightedItem(index);
      },
    );
  }
}

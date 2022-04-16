import 'package:flutter/material.dart';
import 'package:habits_organizer/view/habits/form/import.dart';

class IterationForm extends StatelessWidget {
  const IterationForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioButtonGroupFieldBlocBuilder<String>(
      selectFieldBloc: BlocProvider.of<AllFieldsFormBloc>(context).iteration,
      decoration: const InputDecoration(
          labelText: 'iterations',
          floatingLabelAlignment: FloatingLabelAlignment.center,
          border: InputBorder.none),
      groupStyle: const TableGroupStyle(crossAxisCount: 3),
      itemBuilder: (context, item) => FieldItem(
        child: Text(item),
      ),
    );
  }
}

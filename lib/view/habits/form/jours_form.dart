import 'package:flutter/material.dart';
import 'package:habits_organizer/view/habits/form/import.dart';

class JoursForm extends StatelessWidget {
  const JoursForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxGroupFieldBlocBuilder<String>(
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      multiSelectFieldBloc: BlocProvider.of<AllFieldsFormBloc>(context).jours,
      groupStyle: const TableGroupStyle(crossAxisCount: 3),
      itemBuilder: (context, item) => FieldItem(child: Text(item)),
    );
  }
}

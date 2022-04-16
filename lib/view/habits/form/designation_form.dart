import 'package:flutter/material.dart';
import 'package:habits_organizer/view/habits/form/import.dart';

class DesignationForm extends StatelessWidget {
  const DesignationForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldBlocBuilder(
      textFieldBloc: BlocProvider.of<AllFieldsFormBloc>(context).designation,
      decoration: const InputDecoration(
        labelText: 'designation',
        border: InputBorder.none,
        floatingLabelAlignment: FloatingLabelAlignment.center,
        prefixIcon: Icon(Icons.drive_file_rename_outline),
      ),
    );
  }
}

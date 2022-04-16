import 'package:flutter/material.dart';
import 'package:habits_organizer/view/habits/form/import.dart';

class FrequenceForm extends StatelessWidget {
  const FrequenceForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> frequence = Habit.availableFrequences;
    return SliderFieldBlocBuilder(
        inputFieldBloc: BlocProvider.of<AllFieldsFormBloc>(context).frequence,
        divisions: frequence.length - 1,
        decoration: const InputDecoration(
          border: InputBorder.none,
          labelText: "frequence",
          floatingLabelAlignment: FloatingLabelAlignment.center,
          fillColor: Colors.greenAccent,
        ),
        inactiveColor: Colors.greenAccent,
        activeColor: Colors.cyan,
        labelBuilder: (context, value) =>
            (frequence[(value * (frequence.length - 1)).toInt()]));
  }
}

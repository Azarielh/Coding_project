import 'package:flutter/material.dart';
import 'package:habits_organizer/view/habits/form/import.dart';

class IntervalForm extends StatelessWidget {
  const IntervalForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> intervals = Habit.availableIntervals;
    return SliderFieldBlocBuilder(
        inputFieldBloc: BlocProvider.of<AllFieldsFormBloc>(context).interval,
        divisions: intervals.length - 1,
        decoration: InputDecoration(
          border: InputBorder.none,
          label: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Flexible(child: Icon(Icons.today)),
              Flexible(child: Icon(Icons.alarm)),
              Flexible(child: Icon(Icons.wb_sunny_outlined)),
              Flexible(child: Icon(Icons.shield_moon_outlined))
            ],
          ),
        ),
        inactiveColor: Colors.greenAccent,
        activeColor: Colors.cyan,
        labelBuilder: (context, value) {
          return (intervals[(value * (intervals.length - 1)).toInt()]);
        });
  }
}

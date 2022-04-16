import 'package:flutter/material.dart';
import 'package:habits_organizer/view/habits/form/import.dart';

class EditHabitArgument {
  final Habit habit;

  EditHabitArgument(this.habit);
}

class NewEditHabit extends StatefulWidget {
  const NewEditHabit({Key? key}) : super(key: key);

  static const String newEditHabitRouteName = "/habit/new";

  @override
  State<StatefulWidget> createState() => NewEditHabitState();
}

class NewEditHabitState extends State {
  Offset offset = const Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    EditHabitArgument? args =
        ModalRoute.of(context)!.settings.arguments as EditHabitArgument?;
    return HabitForm(habit: args?.habit);
  }
}

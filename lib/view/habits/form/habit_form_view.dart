import 'package:flutter/material.dart';
import 'package:habits_organizer/context/context.dart';
import 'package:habits_organizer/view/habits/form/import.dart';
import 'package:page_transition/page_transition.dart';

class EditHabitArgument extends PageTransitionArgument {
  final Habit? habit;
  final PageTransitionType transition;

  EditHabitArgument(this.habit, this.transition) : super(transition);
}

class NewEditHabit extends StatelessWidget {
  const NewEditHabit({Key? key}) : super(key: key);

  static const String newEditHabitRouteName = "/habit/new";

  @override
  Widget build(BuildContext context) {
    EditHabitArgument? args =
        ModalRoute.of(context)!.settings.arguments as EditHabitArgument?;
    return HabitForm(habit: args?.habit);
  }
}

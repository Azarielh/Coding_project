import 'package:flutter/material.dart';
import 'package:habits_organizer/database/models/models.dart';
import 'package:habits_organizer/view/habits/form/habit_form_view.dart';
import 'package:page_transition/page_transition.dart';

class HabitTileButtonBar extends StatelessWidget {
  final Habit habit;
  final Future<bool> Function(BuildContext context, DismissDirection direction)
      delete;

  const HabitTileButtonBar(
      {Key? key, required this.habit, required this.delete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceAround,
      buttonHeight: 52.0,
      buttonMinWidth: 90.0,
      children: <Widget>[
        TextButton(
          onPressed: () {
            delete(context, DismissDirection.down).then((value) {
              if (value == true) {
                Navigator.pop(context);
              }
            });
          },
          child: Column(
            children: const <Widget>[
              Icon(Icons.delete),
              Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
              Text('Delete'),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, NewEditHabit.newEditHabitRouteName,
                arguments: EditHabitArgument(habit, PageTransitionType.rightToLeftWithFade));
          },
          child: Column(
            children: const <Widget>[
              Icon(Icons.edit),
              Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
              Text('edit'),
            ],
          ),
        ),
      ],
    );
  }
}

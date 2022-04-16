import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:habits_organizer/database/models/models.dart';

class DeleteHabitValidation {
  final DialogTransitionType animationType;
  final Curve? curve;

  DeleteHabitValidation({required this.animationType, this.curve});

  Future<bool> showConfirmDialog(BuildContext context, Habit habit) async {
    bool confirm = false;
    await showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ClassicGeneralDialogWidget(
          titleText: 'supprimer ?',
          contentText: habit.designation,
          onPositiveClick: () {
            Navigator.pop(context);
            confirm = true;
          },
          onNegativeClick: () {
            Navigator.pop(context);
            confirm = false;
          },
        );
      },
      animationType: animationType,
      curve: curve ?? Curves.fastOutSlowIn,
      duration: const Duration(seconds: 1),
    );
    return (confirm);
  }
}

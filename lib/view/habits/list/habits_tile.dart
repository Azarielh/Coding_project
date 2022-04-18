import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:habits_organizer/context/context.dart';
import 'package:habits_organizer/database/models/habits.dart';
import 'package:habits_organizer/popup/delete_habit_validation.dart';
import 'package:habits_organizer/view/habits/list/habit_tile_body.dart';
import 'package:page_transition/page_transition.dart';
import 'habit_tile_button_bar.dart';

class HabitTile extends StatelessWidget {
  final Habit habit;
  final int idx;

  const HabitTile({Key? key, required this.habit, required this.idx})
      : super(key: key);

  Future<bool> confirmDismiss(
      BuildContext context, DismissDirection direction) async {
    Map a = <DismissDirection, DialogTransitionType>{
      DismissDirection.startToEnd: DialogTransitionType.slideFromRight,
      DismissDirection.endToStart: DialogTransitionType.slideFromLeft,
      DismissDirection.down: DialogTransitionType.scale,
      DismissDirection.up: DialogTransitionType.scale
    };

    bool delete = await DeleteHabitValidation(animationType: a[direction])
        .showConfirmDialog(context, habit);
    if (delete == true) {
      await HabitOrganizerContext.of(context).removeHabit(habit);
    }
    return delete;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FractionallySizedBox(
        widthFactor: 0.9,
        alignment: Alignment(idx % 2 == 0 ? -0.9 : 0.9, 0),
        child: Dismissible(
          confirmDismiss: (val) async => await confirmDismiss(context, val),
          key: Key("-${habit.id}-"),
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, HeroHabitView.habitHeroRouteName,
                  arguments: HabitTileArgument(habit, confirmDismiss));
            },
            child: ListTile(
              tileColor: Colors.white54,
              leading: Hero(
                  tag: "demo ${habit.id}",
                  child: CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: Image.asset("assets/images/yoga.png"))),
              title: Text(habit.designation),
      child: Align(
        alignment: Alignment(idx % 2 == 0 ? -0.9 : 0.9, 0),
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Dismissible(
            confirmDismiss: (val) async => await confirmDismiss(context, val),
            key: Key("-${habit.id}-"),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/habit/info",
                    arguments: HabitTileArgument(habit, confirmDismiss, PageTransitionType.rightToLeftWithFade));
              },
              child: ListTile(
                tileColor: Colors.white54,
                leading: Hero(
                    tag: "demo ${habit.id}",
                    child: CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: Image.asset("assets/images/yoga.png"))),
                title: Text(habit.designation),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HabitTileArgument extends PageTransitionArgument {
  final Habit habit;
  final Future<bool>Function (BuildContext context, DismissDirection direction)delete;
  final PageTransitionType transition;



  HabitTileArgument(this.habit, this.delete, this.transition) : super(transition);
}

class HeroHabitView extends StatelessWidget {
  const HeroHabitView({Key? key}) : super(key: key);

  static const String habitHeroRouteName = "/habit/info";

  @override
  Widget build(BuildContext context) {
    HabitTileArgument args =
        ModalRoute.of(context)!.settings.arguments as HabitTileArgument;
    return Material(
      color: Theme.of(context).primaryColor.withOpacity(0.7),
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Hero(
                  tag: "demo ${args.habit.id}",
                  child: CircleAvatar(
                      backgroundColor: Colors.orange,
                      radius: MediaQuery.of(context).size.longestSide / 10,
                      child: Image.asset(
                        "assets/images/yoga.png",
                        fit: BoxFit.contain,
                      )),
                ),
                Center(
                    child: Text(
                  args.habit.designation,
                  textScaleFactor: 3,
                )),
                HabitTileBody(habit: args.habit),
                HabitTileButtonBar(habit: args.habit, delete: args.delete)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

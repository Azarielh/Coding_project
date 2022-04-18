import 'package:flutter/material.dart';
import 'package:habits_organizer/libraries/cloud_background.dart';
import 'package:habits_organizer/libraries/habit_organiser_shimmer.dart';
import 'package:habits_organizer/view/habits/list/habit_list_view.dart';
import 'package:habits_organizer/view/habits/stats/habits_stat.dart';
import 'package:habits_organizer/view/todo/todo_list_body.dart';
import 'package:habits_organizer/context.dart';
import 'package:page_transition/page_transition.dart';

class TodoView extends StatelessWidget {
  const TodoView({Key? key}) : super(key: key);

  static const String todoRouteName = "/todo";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle:true,
          elevation: 2,
          backgroundColor: Colors.deepPurple,
          title: const HabitOrganizerShimmer(
              duration: Duration(seconds: 3), child: Text("Daily Task")),
          leading: HabitOrganizerShimmer(
            duration: const Duration(seconds: 3),
            child: IconButton(
                onPressed: () => Navigator.popAndPushNamed(context,HabitStat.habitStatRouteName,
                arguments: PageTransitionArgument(PageTransitionType.leftToRightWithFade)),
                icon: const Icon(Icons.query_stats)),
          ),
          actions: [
            HabitOrganizerShimmer(
                duration: const Duration(seconds: 3),
                child: IconButton(
                    onPressed: () => Navigator.popAndPushNamed(context, Listhabits.listhabitsRouteName,
                        arguments: PageTransitionArgument(PageTransitionType.leftToRightWithFade)
                    ),
                    icon: const Icon(Icons.list_rounded)))
          ]),
      body: const CloudBackground(child: TodoListBody()),
    );
  }
}

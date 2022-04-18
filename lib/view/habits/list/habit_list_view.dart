import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:habits_organizer/context/context.dart';
import 'package:habits_organizer/libraries/cloud_background.dart';
import 'package:habits_organizer/libraries/habit_organiser_shimmer.dart';
import 'package:habits_organizer/view/habits/form/habit_form_view.dart';
import 'package:habits_organizer/view/habits/form/import.dart';
import 'package:habits_organizer/view/habits/list/habits_tile.dart';
import 'package:habits_organizer/view/todo/todo_list_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Listhabits extends StatelessWidget {
  const Listhabits({Key? key}) : super(key: key);

  static const listhabitsRouteName = "/habits";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            elevation: 2,
            backgroundColor: Colors.deepPurple,
            title: const HabitOrganizerShimmer(
                duration: Duration(seconds: 3), child: Text("Habits")),
            leading: HabitOrganizerShimmer(
              duration: const Duration(seconds: 3),
              child: IconButton(
                  onPressed: () => Navigator.popAndPushNamed(
                      context, TodoView.todoRouteName,
                      arguments: PageTransitionArgument(
                          PageTransitionType.leftToRightWithFade)),
                  icon: const Icon(Icons.check_box_outlined)),
            ),
            actions: [
              HabitOrganizerShimmer(
                  duration: const Duration(seconds: 3),
                  child: IconButton(
                      onPressed: () => Navigator.popAndPushNamed(
                          context, NewEditHabit.newEditHabitRouteName,
                          arguments: EditHabitArgument(
                              null, PageTransitionType.leftToRightWithFade)),
                      icon: const Icon(Icons.add)))
            ]),
        body: CloudBackground(
          child: Consumer<HabitOrganizerContext>(
              builder: (context, appContext, child) {
            var habitsMapList = [];
            for (var habit in appContext.habits) {
              habitsMapList.add(habit.asMap());
            }
            return GroupedListView<dynamic, String>(
              padding: EdgeInsets.zero,
              elements: habitsMapList,
              groupBy: (dynamic element) => element['frequence'],
              stickyHeaderBackgroundColor: Colors.transparent,
              groupSeparatorBuilder: (String groupByValue) {
                return HabitOrganizerShimmer(
                  child: Text(groupByValue,
                      textAlign: TextAlign.center, textScaleFactor: 2),
                );
              },
              indexedItemBuilder: (context, dynamic element, index) {
                HabitOrganizerContext appContext =
                    HabitOrganizerContext.of(context);
                Habit habit = appContext.habits
                    .firstWhere((habit) => habit.id == element['id']);
                return HabitTile(habit: habit, idx: index);
              },
              itemComparator: (item1, item2) =>
                  item1['designation'].compareTo(item2['designation']),
              useStickyGroupSeparators: false,
              order: GroupedListOrder.ASC, // optional
            );
          }),
        ));
  }
}

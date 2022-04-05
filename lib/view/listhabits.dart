import 'package:flutter/material.dart';
import 'package:habits_organizer/context.dart';
import 'package:habits_organizer/database/models/habits.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:root/home.dart';
import '../appbars.dart';
import 'new_edit_habits.dart';

class DeleteHabitValidation {
  Future<bool> showConfirmDialog(
      BuildContext context, Habit habit, DismissDirection direction) async {
    bool confirm = false;
    await showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ClassicGeneralDialogWidget(
          titleText: 'supprimer ?',
          contentText: habit.designation,
          onPositiveClick: () {
            HabitOrganizerContext.ofRootContext
                .removeHabit(habit)
                .then((value) {
              Navigator.of(context).pop();
              confirm = true;
            });
          },
          onNegativeClick: () {
            Navigator.of(context).pop();
            confirm = false;
          },
        );
      },
      animationType: direction == DismissDirection.startToEnd
          ? DialogTransitionType.slideFromLeft
          : DialogTransitionType.slideFromRight,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(seconds: 1),
    );
    return (confirm);
  }
}

class Listhabits extends StatelessWidget {
  const Listhabits({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> habitsMapList = [];
    for (Habit habit in HabitOrganizerContext.ofRootContext.habits) {
      habitsMapList.add(habit.asMap());
    }
    return GroupedListView<dynamic, String>(
      padding: EdgeInsets.zero,
      elements: habitsMapList,
      groupBy: (dynamic element) => element['frequence'],
      stickyHeaderBackgroundColor: Colors.indigo,
      groupSeparatorBuilder: (String groupByValue) {
        return ListTile(
            tileColor: Colors.indigo,
            title: Shimmer.fromColors(
              baseColor: Colors.red,
              period: const Duration(seconds: 3),
              highlightColor: Colors.yellow,
              child: Text(groupByValue,
                  textAlign: TextAlign.center,
                  textScaleFactor: 2,
                  style: const TextStyle(color: Colors.white)),
          )
        );
      },
      indexedItemBuilder: (context, dynamic element, index) {
        Habit habit = Habit()..fromMap(element);
        return HabitTile(habit: habit, idx: index);
      },
      itemComparator: (item1, item2) => item1['designation'].compareTo(item2['designation']),
      useStickyGroupSeparators: true,
      order: GroupedListOrder.ASC, // optional
    );
  }
}

class HabitTile extends StatelessWidget {
  final Habit habit;
  final int idx;

  const HabitTile({Key? key, required this.habit, required this.idx})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/loading.png"), fit: BoxFit.cover)),
      child: Align(
        alignment: Alignment((idx % 2) == 0 ? 1 : -1, 0),
        child: FractionallySizedBox(
          widthFactor: 0.92,
          child: Card(
            elevation: 20,
            shadowColor: Colors.white,
            child: Dismissible(
              confirmDismiss: (val) async {
                return await DeleteHabitValidation()
                    .showConfirmDialog(context, habit, val);
              },
              background: FractionallySizedBox(
                heightFactor: 1,
                widthFactor: 1,
                child: Container(
                  color: Colors.red,
                  child: const Align(
                    alignment: Alignment(-0.9, 0),
                    child: Icon(Icons.restore_from_trash_rounded,
                        color: Colors.white),
                  ),
                ),
              ),
              key: Key(habit.id.toString()),
              child: Container(
                color: (idx % 2 == 0) ? Colors.blue : Colors.redAccent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpandedTile(
                    title: Text(
                      habit.designation,
                      textAlign: TextAlign.center,
                    ),
                    leading: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Home.ofContext?.body = NewEditHabit(
                            habit: habit,
                          );
                          Home.ofContext?.appBar =
                              AppBarLibrary.newHabitsAppBar();
                        },
                        icon: const Icon(Icons.edit)),
                    content: Column(
                      children: [
                        Text("frequence ${habit.frequence}"),
                        Text("jours ${habit.jours}"),
                        Text("iteration ${habit.iteration}"),
                        Text("interval ${habit.interval}")
                      ],
                    ),
                    controller: ExpandedTileController(isExpanded: false),
                    theme: ExpandedTileThemeData(
                        headerColor:
                            (idx % 2 == 0) ? Colors.blue : Colors.redAccent,
                        contentBackgroundColor:
                            (idx % 2 == 0) ? Colors.blue : Colors.redAccent,
                        headerSplashColor: Colors.transparent),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

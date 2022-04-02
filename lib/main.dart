import 'package:flutter/material.dart';
import 'package:habits_organizer/context.dart';
import 'package:habits_organizer/view/new_habits.dart';
import 'package:root/root.dart';
import 'package:root/home.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weekday_selector/weekday_selector.dart';

void main() {
  runApp(Root(
      title: 'Habits Organizer',
      homeScreen: const TodoListView(),
      appContext: HabitOrganizerContext(),
      appBar: AppBarLibrary.homeAppBar()));
}

class AppBarLibrary {
  static AppBar homeAppBar() {
    return AppBar(
        elevation: 2,
        backgroundColor: Colors.deepPurple[400],
        title: Shimmer.fromColors(
            baseColor: Colors.red,
            highlightColor: Colors.yellow,
            child: const Text(
              "Todo Today",
              style: TextStyle(color: Colors.white),
            )),
        actions: [
          Shimmer.fromColors(
            baseColor: Colors.red,
            highlightColor: Colors.yellow,
            child: IconButton(
                onPressed: () {
                  Home.ofContext?.body = const AddHabbits();
                  Home.ofContext?.appBar = AppBarLibrary.profilAppBar();
                },
                icon: const Icon(Icons.star_half, color: Colors.white)),
          )
        ]);
  }

  static AppBar profilAppBar() {
    return AppBar(
        elevation: 2,
        backgroundColor: Colors.deepPurple[400],
        title: Shimmer.fromColors(
            baseColor: Colors.red,
            highlightColor: Colors.yellow,
            child: const Text("Habits")),
        leading: Shimmer.fromColors(
          baseColor: Colors.red,
          highlightColor: Colors.yellow,
          child: IconButton(
              onPressed: () {
                Home.ofContext?.body = const TodoListView();
                Home.ofContext?.appBar = AppBarLibrary.homeAppBar();
              },
              icon: const Icon(Icons.keyboard_return, color: Colors.white)),
        ),
        actions: [
          Shimmer.fromColors(
            baseColor: Colors.red,
            highlightColor: Colors.yellow,
            child: IconButton(
                onPressed: () {
                  Home.ofContext?.body = const NewHabit();
                  Home.ofContext?.appBar = AppBarLibrary.newHabbitsAppBar();
                },
                icon: const Icon(Icons.add, color: Colors.white)),
          )
        ]);
  }

  static AppBar newHabbitsAppBar() {
    return AppBar(
        elevation: 2,
        backgroundColor: Colors.deepPurple[400],
        title: Shimmer.fromColors(
            baseColor: Colors.red,
            highlightColor: Colors.yellow,
            child: const Text("New Habit")),
        leading: Shimmer.fromColors(
          baseColor: Colors.red,
          highlightColor: Colors.yellow,
          child: IconButton(
              onPressed: () {
                Home.ofContext?.body = const AddHabbits();
                Home.ofContext?.appBar = AppBarLibrary.profilAppBar();
              },
              icon: const Icon(Icons.keyboard_return, color: Colors.white)),
        ));
  }
}

class AddHabbits extends StatelessWidget {
  const AddHabbits({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(
        color: Colors.deepOrangeAccent,
        child: Column(
          children: [
            const ListTile(
              title: Text(
                  "me brosser les dentss c 'est le principale c'est l'essentiel pour le moment c'est ce que je prefere"),
              trailing: Text("hedomadaire"),
            ),
            WeekdaySelector(
              onChanged: (int day) {},
              values: const [false, false, false, false, false, false, false],
            )
          ],
        ),
      ),
      Card(
        color: Colors.deepOrangeAccent,
        child: Column(
          children: [
            const ListTile(
              title: Text(
                  "me brosser les dentss c 'est le principale c'est l'essentiel pour le moment c'est ce que je prefere"),
              trailing: Text("hedomadaire"),
            ),
            WeekdaySelector(
              onChanged: (int day) {},
              values: const [false, false, false, false, false, false, false],
            )
          ],
        ),
      )
    ]);
  }
}

class TodoListView extends StatelessWidget {
  const TodoListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Align(
          alignment: Alignment(-1, 0),
          child: FractionallySizedBox(
            widthFactor: 0.7,
            child: Card(
              color: Colors.black12,
              child: ListTile(
                leading: Icon(Icons.opacity),
                title: Text(
                  "bonjour je sq azeaze  azeae a  zze az",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                subtitle: Text("exemple"),
                dense: true,
                trailing: Icon(Icons.apps),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment(1, 0),
          child: FractionallySizedBox(
            widthFactor: 0.7,
            child: Card(
              color: Colors.black12,
              child: ListTile(
                leading: Icon(Icons.opacity),
                title: Text("bonjour", style: TextStyle(color: Colors.white)),
                subtitle: Text("exemple"),
                dense: true,
                trailing: Icon(Icons.apps),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

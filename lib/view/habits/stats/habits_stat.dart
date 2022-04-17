import 'package:flutter/material.dart';
import 'package:habits_organizer/libraries/libraries.dart';
import 'package:habits_organizer/view/habits/list/habit_list_view.dart';

class HabitStat extends StatefulWidget {
  const HabitStat({Key? key}) : super(key: key);

  static const String habitStatRouteName = '/habits/stat';

  @override
  State<StatefulWidget> createState() => HabitStatState();
}

class HabitStatState extends State<HabitStat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle:true,
          elevation: 2,
          backgroundColor: Colors.deepPurple,
          title:
              const HabitOrganizerShimmer(child: Text("Encrage des Habitudes")),
          leading: HabitOrganizerShimmer(
            child: IconButton(
                onPressed: () => Navigator.popAndPushNamed(
                    context, Listhabits.listhabitsRouteName),
                icon: const Icon(Icons.list_rounded, color: Colors.white)),
          ),
          actions: [
            HabitOrganizerShimmer(
              child: IconButton(
                  onPressed: () => Navigator.popAndPushNamed(
                      context, Listhabits.listhabitsRouteName),
                  icon: const Icon(Icons.check_box_outlined, color: Colors.white)),
            )
          ]),
        body: const CloudBackground()
    );
  }
}


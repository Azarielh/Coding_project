import 'package:flutter/material.dart';
import 'package:habits_organizer/context.dart';
import 'package:habits_organizer/database/models/models.dart';

class HabitTileBody extends StatelessWidget {
  final Habit habit;

  const HabitTileBody({Key? key, required this.habit}) : super(key: key);
///Bloc affichage des options de l'habitude [habit] sélectionnée
  @override
  Widget build(BuildContext context) {
    return Banner(
        location: BannerLocation.topEnd,
        message: '${habit.iteration} / ${habit.frequence}',
        child: Column(
          children: [
            Visibility(
              visible: habit.frequence != Frequence.mensuel,
              child: JoursHabitTile(days: habit.jours?.split(' ')),
              replacement: Container(),
            ),
            Visibility(
              visible: habit.frequence == Frequence.daily,
              child: IntervalHabitTile(intervals: habit.interval?.split(' ')),
              replacement: Container(),
            )
          ],
        ));
  }
}
///Ligne Règlage intervale
class IntervalButton extends StatelessWidget {
  final String name;
  final Function() onTap;
  final bool enable;

  const IntervalButton(
      {Key? key, required this.name, required this.onTap, required this.enable})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector( //Transforme la 'chip' en bouton
        onTap: onTap,
        child: Chip(
          label: Text(name),
          elevation: 5,
          visualDensity: VisualDensity.standard,
          backgroundColor: enable ? Colors.green : Colors.transparent,
        ));
  }
}
class IntervalHabitTile extends StatelessWidget {
  final List<String>? intervals;
  final ValueNotifier<bool> updater = ValueNotifier<bool>(false);

  IntervalHabitTile({Key? key, required this.intervals}) : super(key: key);

  void onTap(BuildContext context, bool enable, String name) {
    if (intervals == null) return;
    Habit habit = context.findAncestorWidgetOfExactType<HabitTileBody>()!.habit;
    intervals!.clear();
    intervals!.add(name);
    updater.value = !updater.value;
    HabitOrganizerContext.of(context).editCreateHabit(
        data: {"interval": intervals!.first}, habit: habit, notifie: false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Interval"),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(color: Colors.black),
            )),
          ],
        ),
        ValueListenableBuilder(
            valueListenable: updater,
            builder: (context, value, child) {
              return SizedBox(
                height: MediaQuery.of(context).size.longestSide / 10,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          MediaQuery.of(context).size.longestSide ~/ 150,
                      crossAxisSpacing: 5,
                      childAspectRatio: 1 / 1,
                      mainAxisSpacing: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  itemBuilder: (_, index) {
                    bool enable = intervals != null &&
                        intervals!.contains(Habit.availableIntervals[index]);
                    String name = Habit.availableIntervals[index];
                    return Center(
                      child: IntervalButton(
                          enable: enable,
                          name: name,
                          onTap: () => onTap(context, enable, name)),
                    );
                  },
                  itemCount: Habit.availableIntervals.length,
                ),
              );
            })
      ],
    );
  }
}//Fin ligne interval
///Bloc réglages jours
class JoursButton extends StatelessWidget {
  final ValueNotifier<bool> updater = ValueNotifier<bool>(false);
  final String name;
  final Function() onTap;
  final bool enable;

  JoursButton(
      {Key? key, required this.name, required this.onTap, required this.enable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tmp = enable;
    return ValueListenableBuilder(
        valueListenable: updater,
        builder: (context, value, child) {
          return GestureDetector( //Transforme la 'chip' en bouton
              onTap: () {
                onTap();
                tmp = !tmp;
                updater.value = !updater.value;
              },
              child: Chip(
                label: Text(name),
                elevation: 5,
                visualDensity: VisualDensity.standard,
                backgroundColor: tmp ? Colors.green : Colors.transparent,
              ));
        });
  }
}

class JoursHabitTile extends StatelessWidget {
  final List<String>? days;

  const JoursHabitTile({Key? key, required this.days}) : super(key: key);

  void onTap(BuildContext context, bool enable, String name) {
    Habit habit = context.findAncestorWidgetOfExactType<HabitTileBody>()!.habit;
    enable ? days!.remove(name) : days!.add(name);
    HabitOrganizerContext.of(context).editCreateHabit(
      data: {"jours": days!.join(' ')},
      habit: habit,
    );
  }
///Structure graphique modifs jours
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("days"),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(color: Colors.black),
            )),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.longestSide / 7,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.longestSide ~/ 150,
                crossAxisSpacing: 5,
                childAspectRatio: 2 / 1,
                mainAxisSpacing: 20),
            padding: const EdgeInsets.only(right: 30),
            itemBuilder: (_, index) {
              bool enable =
                  days != null && days!.contains(Habit.availableJours[index]);
              String name = Habit.availableJours[index];
              return Center(
                child: JoursButton(
                    enable: enable,
                    name: name,
                    onTap: () => onTap(context, enable, name)),
              );
            },
            itemCount: Habit.availableJours.length,
          ),
        ),
      ],
    );
  }
}//Fin bloc réglages jour

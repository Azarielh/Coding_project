import 'package:flutter/material.dart';
import 'package:weekday_selector/weekday_selector.dart';

// ignore: camel_case_types
class Listhabits extends StatelessWidget {
  const Listhabits({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(
        color: Colors.blue,
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
        color: Colors.blue,
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
              fillColor: Colors.white24,
              color: Colors.black87,
            ),
          ],
        ),
      )
    ]);
  }
}

import 'package:flutter/cupertino.dart';
import 'database/models/models.dart';
import 'package:root/context.dart';
import 'package:provider/provider.dart';
import 'package:root/root.dart';

class HabitOrganizerContext extends AppContext {
  List<Habits> habits = [];
  List<Habits> todo = [];

  static HabitOrganizerContext get ofRootContext {
    return Provider.of<HabitOrganizerContext>(Root.context!, listen: false);
  }

  static HabitOrganizerContext of(BuildContext context, {listen = false}) {
    return Provider.of<HabitOrganizerContext>(context, listen: listen);
  }
}
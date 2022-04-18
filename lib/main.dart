import 'package:flutter/material.dart';
import 'package:habits_organizer/context/context.dart';
import 'package:habits_organizer/view/habits/form/habit_form_view.dart';
import 'package:habits_organizer/view/habits/list/habit_list_view.dart';
import 'package:habits_organizer/view/habits/list/habits_tile.dart';
import 'package:habits_organizer/view/habits/stats/habits_stat.dart';
import 'package:habits_organizer/view/todo/todo_list_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:root/root.dart';

/// Regle d'apparition d'une daily Task
/// 1 - Les Habit quotidien
///     si nous somme le jours d'apparition
///     le champ iteration correspond au nombre de fois que la tache devra etre realisé

/// 2 - Les habits hebdo
///     doit etre validé iteration fois
///     de preference les jours (X)
///
/// 3 - Les habits mensuel
///     doit etre realisé interval fois par mois

Future<dynamic> onLoading(BuildContext context) async {
  await HabitOrganizerContext.of(context).getAllHabits();
  await HabitOrganizerContext.of(context).checkForTotoTodayTodoToday();
}

void main() {
  ThemeData appTheme = ThemeData.dark()
    ..copyWith(
        primaryColor: Colors.purple[400],
        appBarTheme: ThemeData.dark()
            .appBarTheme
            .copyWith(backgroundColor: Colors.purple[400]));

  runApp(Root(
    title: 'Habits Organizer',
    initialRoute: TodoView.todoRouteName,
    theme: appTheme,
    routes: const {},
    appContext: HabitOrganizerContext(),
    onLoading: onLoading,
    onLoadingScreen: Container(),
    onLoadingMinDuration: const Duration(seconds: 7),
    debugShowCheckedModeBanner: false,
    showPerformanceOverlay: false,
    showSemanticsDebugger: false,
    debugShowMaterialGrid: false,
    onGenerateRoute: (settings) {
      PageTransitionArgument? ptype =
          settings.arguments as PageTransitionArgument?;
      PageTransitionType? type = ptype?.type;

      switch (settings.name) {
        case TodoView.todoRouteName:
          return PageTransition(
              child: const TodoView(),
              type: type ?? PageTransitionType.fade,
              settings: settings);
        case Listhabits.listhabitsRouteName:
          return PageTransition(
              child: const Listhabits(),
              type: type ?? PageTransitionType.fade,
              settings: settings);
        case NewEditHabit.newEditHabitRouteName:
          return PageTransition(
              child: const NewEditHabit(),
              type: type ?? PageTransitionType.fade,
              settings: settings);
        case HabitStat.habitStatRouteName:
          return PageTransition(
              child: const HabitStat(),
              type: type ?? PageTransitionType.fade,
              settings: settings);
        case HeroHabitView.habitHeroRouteName:
          return PageTransition(
              child: const HeroHabitView(),
              type: type ?? PageTransitionType.fade,
              settings: settings);
        default:
          return null;
      }
    },
  ));
}

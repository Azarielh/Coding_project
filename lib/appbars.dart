import 'package:flutter/material.dart';
import 'package:root/home.dart';
import 'package:shimmer/shimmer.dart';
import 'package:habits_organizer/view/listhabits.dart';
import 'view/habits_stat.dart';
import 'view/new_habits.dart';
import 'view/todolistview.dart';

///File with all Appbar required from different pages
class AppBarLibrary {
  static AppBar homeAppBar() {
    return AppBar(
      ///Nom de la page
        backgroundColor: Colors.deepPurple,
        title: Shimmer.fromColors(
            baseColor: Colors.red,
            highlightColor: Colors.yellow,
            child: const Text("Daily Task")),
        /// statApp Button
        actions: [
          Shimmer.fromColors(
            baseColor: Colors.red,
            highlightColor: Colors.yellow,
            child: IconButton(
                onPressed: () {
                  Home.ofContext?.body = const HabitStat();
                  Home.ofContext?.appBar = AppBarLibrary.statAppBar();
                },
                icon: const Icon(Icons.query_stats, color: Colors.white)),
          ),
          /// Habits Button
          Shimmer.fromColors(
            baseColor: Colors.red,
            highlightColor: Colors.yellow,
            child: IconButton(
                onPressed: () {
                  Home.ofContext?.body = const Listhabits();
                  Home.ofContext?.appBar = AppBarLibrary.profilAppBar();
                },
                icon: const Icon(Icons.star_half, color: Colors.white)),
          )
        ]);
  }// homeAppBar

  static AppBar profilAppBar() {
    return AppBar(
      /// Nom de la page
        elevation: 2,
        backgroundColor: Colors.deepPurple[400],
        title: Shimmer.fromColors(
            baseColor: Colors.red,
            highlightColor: Colors.yellow,
            child: const Text("Habits")),
        /// Bouton de retour
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
                  Home.ofContext?.appBar = AppBarLibrary.newHabitsAppBar();
                },
                icon: const Icon(Icons.add, color: Colors.white)),
          )]
    );
  } // profilAppBar

  static AppBar newHabitsAppBar() {
    return AppBar(
      /// Nom de la page
      elevation: 2,
      backgroundColor: Colors.deepPurple[400],
      title: Shimmer.fromColors(
          baseColor: Colors.red,
          highlightColor: Colors.yellow,
          child: const Text("New Habit")),
      /// Bouton de retour
      leading: Shimmer.fromColors(
        baseColor: Colors.red,
        highlightColor: Colors.yellow,
        child: IconButton(
            onPressed: () {
              Home.ofContext?.body = const Listhabits();
              Home.ofContext?.appBar = AppBarLibrary.profilAppBar();
            },
            icon: const Icon(Icons.keyboard_return, color: Colors.white)),
      ),
      actions: [
        Shimmer.fromColors(
          baseColor: Colors.red,
          highlightColor: Colors.yellow,
          child: IconButton(
              onPressed: () {
                Home.ofContext?.body = const TodoListView();
                Home.ofContext?.appBar = AppBarLibrary.homeAppBar();
              },// onPressed
              icon: const Icon(Icons.save_alt)),
        )
      ],);
  }// newHabitsAppBar
  static AppBar statAppBar() {
    return AppBar(
        elevation: 2,
        backgroundColor: Colors.deepPurple[400],

        title: Shimmer.fromColors(
            baseColor: Colors.red,
            highlightColor: Colors.yellow,
            child: const Text("Encrage des Habitudes")),
        /// Bouton de retour
        leading: Shimmer.fromColors(
          baseColor: Colors.red,
          highlightColor: Colors.yellow,
          child: IconButton(
              onPressed: () {
                Home.ofContext?.body = const TodoListView();
                Home.ofContext?.appBar = AppBarLibrary.homeAppBar();
              },
              icon: const Icon(Icons.star_half, color: Colors.white)),
        ),
        actions: [
          Shimmer.fromColors(
            baseColor: Colors.red,
            highlightColor: Colors.yellow,
            child: IconButton(
                onPressed: () {
                  Home.ofContext?.body = const Listhabits();
                  Home.ofContext?.appBar = AppBarLibrary.profilAppBar();
                },
                icon: const Icon(Icons.keyboard_return, color: Colors.white)),
          )
        ]);
  }//stat appbar
}//AppLibrary

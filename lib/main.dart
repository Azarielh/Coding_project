import 'package:flutter/material.dart';
import 'package:habits_organizer/context.dart';
import 'package:root/root.dart';
import 'package:habits_organizer/appbars.dart';
import 'package:habits_organizer/view/todolistview.dart';


Future <dynamic>onLoading() async {
  await Future.delayed(const Duration(seconds: 2));
  await HabitOrganizerContext.ofRootContext.getAllHabits();
}

void main() {
  runApp(Root(
      title: 'Habits Organizer',
      homeScreen: const TodoListView(),
      appContext: HabitOrganizerContext(),
      appBar: AppBarLibrary.homeAppBar(),
      onLoading: onLoading,
      onLoadingScreen: const LoadingScreen(),
  ));
}

class LoadingScreen extends StatelessWidget{
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return FractionallySizedBox(widthFactor: 1,heightFactor: 1,
   child: Image.asset("assets/loading.png",fit: BoxFit.cover,));
  }
}

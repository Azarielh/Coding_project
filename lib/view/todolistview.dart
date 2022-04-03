import 'package:flutter/material.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Align(
          ///Habit 1 leftside
          alignment: Alignment(-1, 0),
          child: FractionallySizedBox(
            widthFactor: 0.7,
            child: Card(
              color: Colors.indigoAccent,
              shadowColor: Colors.blue,
              elevation: 30,
              child: ListTile(
                leading: Icon(Icons.opacity),
                title: Text(
                  "bonjour je sq azeaze  azeae aaz",
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
          ///Habit 2 rightside
          alignment: Alignment(1, 0),
          child: FractionallySizedBox(
            widthFactor: 0.7,
            child: Card(
              color: Colors.redAccent,
              shadowColor: Colors.red,
              elevation: 30,
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
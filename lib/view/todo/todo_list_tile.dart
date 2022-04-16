import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:habits_organizer/context.dart';
import 'package:habits_organizer/database/models/models.dart';
import 'package:habits_organizer/view/todo/loading_bar.dart';
import 'package:transparent_image/transparent_image.dart';

class TodoListTile extends StatelessWidget {
  final ValueNotifier<bool> updater = ValueNotifier<bool>(false);
  final ValueNotifier<bool> complete = ValueNotifier<bool>(false);
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  final Habit habit;
  final Todo todo;

  TodoListTile({Key? key, required this.habit, required this.todo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    updater.value = (todo.done == 1);
    complete.value = (todo.done == 1);
    return ValueListenableBuilder(
        valueListenable: updater,
        builder: (context, value, child) {
          return ValueListenableBuilder(
            valueListenable: complete,
            builder: (context, value, child) {
              return AbsorbPointer(
                absorbing: todo.done == 1,
                child: FractionallySizedBox(
                  widthFactor: 0.95,
                  child: FlipCard(
                      fill: Fill.fillBack,
                      key: cardKey,
                      direction: FlipDirection.VERTICAL,
                      front: Card(
                        elevation: 10,
                        shadowColor: Colors.black54,
                        child: CheckboxListTile(
                          value: updater.value,
                          onChanged: (value) {
                            updater.value = !updater.value;
                            cardKey.currentState?.toggleCard();
                          },
                          tileColor: complete.value
                              ? Colors.green
                              : Colors.transparent,
                          title: Text(habit.designation),
                          subtitle: Text(habit.frequence),
                          secondary: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FadeInImage(
                                image:
                                    const AssetImage("assets/images/yoga.png"),
                                placeholder: MemoryImage(kTransparentImage),
                              )),
                          activeColor: complete.value
                              ? Colors.green[300]
                              : Colors.transparent,
                        ),
                      ),
                      back: Card(
                        elevation: 10,
                        shadowColor: Colors.black54,
                        child: Center(
                          child: CheckboxListTile(
                            checkColor: Colors.green,
                            secondary: FadeInImage(
                              image:
                              const AssetImage("assets/images/yoga.png"),
                              placeholder: MemoryImage(kTransparentImage),
                            ),
                            title: Text(habit.designation),
                            subtitle: ProgBar(onComplete: () {
                              todo.done = 1;
                              updater.value = true;
                              complete.value = true;
                              cardKey.currentState?.toggleCard();
                              HabitOrganizerContext.of(context).lockTodo(todo);
                            }),
                            onChanged: (value) {
                              updater.value = !updater.value;
                              cardKey.currentState?.toggleCard();
                            },
                            value: updater.value,
                          ),
                        ),
                      )),
                ),
              );
            },
          );
        });
  }
}

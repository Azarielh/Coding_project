import 'package:habits_organizer/database/models/model.dart';

class Todo extends Model {
  late int habitId;
  late String dateTime;
  late int done = 0;

  @override
  void fromMap(Map<String, dynamic> data) {
    try {
      if (data.containsKey('habit_id')) {
        habitId = int.parse(data['habit_id'].toString());
      }
      if (data.containsKey('dateTime')) {
        dateTime = data['dateTime'];
      }
      if (data.containsKey('done')) {
        done = int.parse(data['done'].toString());
      }
    } catch (_) {}
    super.fromMap(data);
  }

  @override
  Map<String, dynamic> asMap() {
    Map<String, dynamic> message = {};
    message['habit_id'] = habitId;
    message['dateTime'] = dateTime;
    message['done'] = done;
    message.addAll(super.asMap());
    return message;
  }
}

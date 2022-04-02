import 'package:habits_organizer/database/models/model.dart';

class Todo extends Model {
  late int habitId;
  late int done;      /// 1 == done 0 == not done
  late String when;   /// "1 2 3 4 7"
  late DateTime time;

  @override
  void fromMap(Map<String, dynamic> data) {
    try {
      if (data.containsKey('habits_id')) {
        habitId = int.parse(data['habits_id'].toString());
      }
      if (data.containsKey('done')) {
        done = int.parse(data['done'].toString());
      }
      if (data.containsKey('when')) when = data['when'].toString();
      if (data.containsKey('date_time')) time = DateTime.fromMillisecondsSinceEpoch(int.parse(data['date_time'].toString()));
    } catch (_) {}
    super.fromMap(data);
  }
  @override
  Map<String, dynamic> asMap() {
    Map<String, dynamic> message = {};
    message['habits_id'] = habitId;
    message['done'] = done;
    message['when'] = when;
    message['date_time'] = time;
    message.addAll(super.asMap());
    return message;
  }
}
import 'package:habits_organizer/database/models/model.dart';

class Habit extends Model {
  late String designation;
  late String frequence;

  ///daily, hebdo ou mensuel
  String? jours;

  /// 1=lu 2=ma 3=me 4=je 5=ve 6=sa 7=di
  int iteration = 1;

  /// 1, 2, 3
  String? interval;

  /// matin, midi ou soir

  static List<String> availableIntervals = ["matin", "midi", "soir"];
  static List<String> availableFrequences = ["daily", "hebdo", "mensuel"];
  static List<String> availableJours = [
    "Mo",
    "Tu",
    "We",
    "Th",
    "Fr",
    "Su",
    "So"
  ];
  static List<int> availableIteration = [1, 2, 3];

  @override
  void fromMap(Map<String, dynamic> data) {
    if (data.containsKey('designation')) {
      designation = data['designation'].toString();
    }
    if (data.containsKey('frequence')) frequence = data['frequence'].toString();
    if (data.containsKey('jours') && data['jours'] != null) {
      jours = data['jours'];
    }
    if (data.containsKey('iteration')) {
      iteration = int.parse(data['iteration'].toString());
    }
    if (data.containsKey('interval')) interval = data['interval'].toString();
    super.fromMap(data);
  }

  @override
  Map<String, dynamic> asMap() {
    Map<String, dynamic> message = {};
    message['designation'] = designation;
    message['frequence'] = frequence;
    message['jours'] = jours;
    message['iteration'] = iteration;
    message['interval'] = interval;
    message.addAll(super.asMap());
    return message;
  }
}

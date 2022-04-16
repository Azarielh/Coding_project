import 'package:habits_organizer/database/models/model.dart';

class Frequence {
  static String daily = "daily";
  static String hebdo = "hebdo";
  static String mensuel = "mensuel";
}

class Interval {
  static String matin = "matin";
  static String midi = "midi";
  static String soir = "soir";
  static String none = "aucun";
}

class Jours {
  static const String monday = "Mo";
  static const String tuesday = "Tu";
  static const String wednesday = "We";
  static const String thursday = "Th";
  static const String friday = "Fr";
  static const String saturday = "Sa";
  static const String sunday = "Su";
}

class Habit extends Model {
  late String designation;

  late String frequence;

  String? jours;

  int iteration = 1;

  String? interval;

  static List<String> availableIntervals = [
    Interval.none,
    Interval.matin,
    Interval.midi,
    Interval.soir
  ];
  static List<String> availableFrequences = [
    Frequence.daily,
    Frequence.hebdo,
    Frequence.mensuel
  ];

  static const List<String> availableJours = [
    Jours.monday,
    Jours.tuesday,
    Jours.wednesday,
    Jours.thursday,
    Jours.friday,
    Jours.saturday,
    Jours.sunday
  ];

  static List<int> availableIteration = [1, 2, 3];

  @override
  void fromMap(Map<String, dynamic> data) {
    if (data.containsKey('designation')) designation = data['designation'];
    if (data.containsKey('frequence')) frequence = data['frequence'];
    if (data.containsKey('jours')) jours = data['jours'];
    if (data.containsKey('iteration')) {
      iteration = int.parse(data['iteration'].toString());
    }
    if (data.containsKey('interval')) interval = data['interval'];
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

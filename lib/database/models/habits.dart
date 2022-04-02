import 'package:habits_organizer/database/models/model.dart';

class Habits extends Model {
  String designation = "";
  String frequence =""; ///quotidien, hebdo ou mensuel
  String jours =""; ///1=lu 2=ma 3=me 4=je 5=ve 6=sa 7=di
  String mois = ""; ///
  String interval = ""; /// matin, midi, aprem ou soir
  @override
  void fromMap(Map<String, dynamic> data) {
    if (data.containsKey('designation'))
      designation = data['designation'].toString();
    if (data.containsKey('frequence')) frequence = data['frequence'].toString();
    if (data.containsKey('jours')) jours = data['jours'].toString();
    if (data.containsKey('mois')) mois = data['mois'].toString();
    if (data.containsKey('interval')) interval = data['interval'].toString();
  super.fromMap(data);
  }
    @override
    Map<String, dynamic> asMap() {
      Map<String, dynamic> message = {};
      message['designation'] = designation;
      message['interval'] = interval;
      message.addAll(super.asMap());
      return message;
    }
}
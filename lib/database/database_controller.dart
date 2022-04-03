import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Créer class Singleton
class DatabaseController {
  static final DatabaseController _databaseController = DatabaseController._internal();
  Database? _database;
  factory DatabaseController() {
    return _databaseController;
  }

  DatabaseController._internal();

  Future<Database> get database async {
    _database = await _create();
    return (_database!);
  }

  String habitsTable = "Habits";
  String todoTable = "Todo";

// Créer base de donnée
  Future<Database> _create() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'habit.db');

    //open the database
    _database = await openDatabase(path, version: 1,
    onCreate: (Database db, int version) async {
      // Creer Base de donnée d'habitudes
      await db.execute(
        'CREATE TABLE $habitsTable (id INTEGER PRIMARY KEY, designation TEXT, iteration INTEGER, frequence TEXT, interval TEXT, jours TEXT)'
      );
      // Créer base de donnée To.do
      await db.execute(
          'CREATE TABLE $todoTable (id INTEGER PRIMARY KEY, habits_id INTEGER, kan TEXT, done INTEGER, date_time TEXT)'
      );
    });
    return (_database!);
  }
}
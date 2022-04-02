import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Créer classe Singleton
class DatabaseController {
  static final DatabaseController _databaseController = DatabaseController._internal();
  Database? _database;
  factory DatabaseController() {
    return _databaseController;
  }

  DatabaseController._internal();

  get database => _database;

// Créer base de donnée
  Future<Database> create() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'habit.db');

    //open the database
    _database = await openDatabase(path, version: 1,
    onCreate: (Database db, int version) async {
      // Creer Base de donnée d'habitudes
      await db.execute(
        'CREATE TABLE Habits (id INTEGER PRIMARY KEY, designation TEXT, frequence TEXT, interval TEXT, mois TEXT, jours TEXT)'
      );
      // Créer base de donnée To.do
      await db.execute(
          'CREATE TABLE Todo (id INTEGER PRIMARY KEY, habits_id INTEGER, when TEXT, done INTEGER, date_time INTEGER)'
      );
    });
    return (database);
  }
}
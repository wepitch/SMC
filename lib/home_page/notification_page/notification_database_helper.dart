import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
static late Database database;
static String notificationTable = 'notification';
static String id = 'id';
static String date = 'date';
static String time = 'time';
static String title = 'title';
static String description = 'description';
  // static final DatabaseHelper _instance = DatabaseHelper._internal();
  //
  // factory DatabaseHelper() => _instance;
  //
  // DatabaseHelper._internal();
  //
  // static Database? _database;
  //
  // Future<Database> get database async {
  //   if (_database != null) return _database!;
  //
  //   _database = await createDatabase();
  //   return _database!;
  // }

static Future createDatabase() async {
    String dbName = 'notification.db';
    String path = await getDatabasesPath();
    final dbPath = join(path, dbName);

    database =
    await openDatabase(dbPath, version: 1, onCreate: (database, version)
    {
      database.execute(
          "create table $notificationTable($id INTEGER PRIMARY KEY AUTOINCREMENT,$date text,$time text,$time int,$description text)");
      print('table create successfully');
    });
    }

    // return await openDatabase(
    //   dbPath,
    //   version: 1,
    //   onCreate: (db, version) async {
    //     await db.execute('''
    //       CREATE TABLE notifications (
    //         id INTEGER PRIMARY KEY AUTOINCREMENT,
    //         title TEXT,
    //         body TEXT,
    //         date TEXT,
    //         time TEXT
    //       )
    //     ''');
    //   },
    // );

  }

  // Future<void> saveNotification(
  //     String title, String body, String date, String time) async {
  //   final db = await database;
  //   await db.insert(
  //     'notifications',
  //     {
  //       'title': title,
  //       'body': body,
  //       'date': date,
  //       'time': time,
  //     },
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }
  //
  // Future<List<Map<String, dynamic>>> getNotifications() async {
  //   final db = await database;
  //   return await db.query('notifications', orderBy: 'id DESC');
  // }

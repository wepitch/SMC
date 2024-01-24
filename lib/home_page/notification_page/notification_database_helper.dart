import 'package:myapp/home_page/notification_page/model/notification_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static late Database database;
  static String notificationTable = 'notification';
  static String id = 'id';
  static String date = 'date';
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
    await openDatabase(dbPath, version: 2, onCreate: (database, version) {
      database.execute(
          "create table $notificationTable($id INTEGER PRIMARY KEY AUTOINCREMENT,$date text,$title text,$description text)");
      print('table create successfully');
    });
  }

  static Future addNotification(NotificationModel notificationModel, String title, String body) async {
    await database.rawInsert("insert into $notificationTable values(?,?,?)", [
      notificationModel.date,
      notificationModel.title,
      notificationModel.description,
    ]);
  }

  static Future<List<NotificationModel>> getNotificationData() async {
    List<Map<String, dynamic>> mapList =
    await database.rawQuery("select * from $notificationTable");

    List<NotificationModel> notificationList = [];
    for (int i = 0; i < mapList.length; i++) {
      Map<String, dynamic> map = mapList[i];
      NotificationModel notificationModel = NotificationModel.fromMap(map);
      notificationList.add(notificationModel);
    }
    return notificationList;
  }
}


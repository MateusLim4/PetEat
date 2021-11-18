import 'package:peteat/shared/models/notification/save_notification.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SaveNotificationDB {
  static final SaveNotificationDB instance = SaveNotificationDB._init();

  static Database? _database;

  SaveNotificationDB._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB('configs.db');
      return _database!;
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableConfigs ( 
  ${SavedNotificationDB.id} $idType, 
  ${SavedNotificationDB.idMensagem} $integerType,
''');
  }

  Future<SaveNotification> create(SaveNotification configs) async {
    final db = await instance.database;
    final id = await db.insert(tableConfigs, configs.toJson());
    return configs.copy(id: id);
  }

  Future<SaveNotification> readConfig(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableConfigs,
      columns: SavedNotificationDB.values,
      where: '${SavedNotificationDB.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return SaveNotification.fromJson(maps.first);
    } else {
      throw Exception('Id $id not found');
    }
  }

  Future<List<SaveNotification>> readAllConfigs() async {
    final db = await instance.database;

    final result = await db.query(tableConfigs);

    return result.map((json) => SaveNotification.fromJson(json)).toList();
  }

  Future<int> update(SaveNotification config) async {
    final db = await instance.database;
    return db.update(tableConfigs, config.toJson(),
        where: '${SavedNotificationDB.id} = ?', whereArgs: [config.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(tableConfigs,
        where: '${SavedNotificationDB.id} = ?', whereArgs: [id]);
  }

  // Future close() async {
  //   final db = await instance.database;
  //   db.close();
  // }
}

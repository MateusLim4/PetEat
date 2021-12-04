import 'package:peteat/shared/models/consumido/consumido.dart';
import 'package:peteat/shared/models/notification/save_notification.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class QuantConsumidaDB {
  static final QuantConsumidaDB instance = QuantConsumidaDB._init();

  static Database? _database;

  QuantConsumidaDB._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB('consumo.db');
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
    final floatType = 'REAL NOT NULL';

    await db.execute('''
CREATE TABLE $tableConsumo ( 
  ${QuantConsumidaFields.id} $idType, 
  ${QuantConsumidaFields.idDiaAtual} $integerType,
  ${QuantConsumidaFields.quantConsumida} $floatType)
''');
  }

  Future<QuantConsumida> create(QuantConsumida consumo) async {
    final db = await instance.database;
    final id = await db.insert(tableConsumo, consumo.toJson());
    print('Item criado');
    return consumo.copy(id: id);
  }

  Future<QuantConsumida> readConfig(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableConsumo,
      columns: QuantConsumidaFields.values,
      where: '${SavedNotificationDB.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return QuantConsumida.fromJson(maps.first);
    } else {
      throw Exception('Id $id not found');
    }
  }

  Future<List<QuantConsumida>> readAllConfigs() async {
    final db = await instance.database;

    final result = await db.query(tableConsumo, where: QuantConsumidaFields.id);

    return result.map((json) => QuantConsumida.fromJson(json)).toList();
  }

  Future<int> update(QuantConsumida config) async {
    final db = await instance.database;
    return db.update(tableConsumo, config.toJson(),
        where: '${QuantConsumidaFields.id} = ?', whereArgs: [config.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(tableConsumo,
        where: '${QuantConsumidaFields.id} = ?', whereArgs: [id]);
  }

  // Future close() async {
  //   final db = await instance.database;
  //   db.close();
  // }
}

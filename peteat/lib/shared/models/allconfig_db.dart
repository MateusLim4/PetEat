import 'package:flutter/material.dart';
import 'package:peteat/shared/models/config_user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class AllConfigDatabase {
  static final AllConfigDatabase instance = AllConfigDatabase._init();

  static Database? _database;

  AllConfigDatabase._init();

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
    final textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableConfigs ( 
  ${ConfigFields.id} $idType, 
  ${ConfigFields.hora} $integerType,
  ${ConfigFields.minuto} $integerType,
  ${ConfigFields.diaSemanaId} $integerType,
  ${ConfigFields.diaSemana} $textType,
  ${ConfigFields.alimento} $textType,
  ${ConfigFields.notificacaoId} $integerType)
''');
  }

  Future<ConfigUser> create(ConfigUser configs) async {
    final db = await instance.database;
    final id = await db.insert(tableConfigs, configs.toJson());
    return configs.copy(id: id);
  }

  Future<ConfigUser> readConfig(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableConfigs,
      columns: ConfigFields.values,
      where: '${ConfigFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ConfigUser.fromJson(maps.first);
    } else {
      throw Exception('Id $id not found');
    }
  }

  Future<List<ConfigUser>> readAllConfigs() async {
    final db = await instance.database;

    final orderBy = '${ConfigFields.hora} ASC';
    final result = await db.query(tableConfigs, orderBy: orderBy);

    return result.map((json) => ConfigUser.fromJson(json)).toList();
  }

  Future<int> update(ConfigUser config) async {
    final db = await instance.database;
    return db.update(tableConfigs, config.toJson(),
        where: '${ConfigFields.id} = ?', whereArgs: [config.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db
        .delete(tableConfigs, where: '${ConfigFields.id} = ?', whereArgs: [id]);
  }

  // Future close() async {
  //   final db = await instance.database;
  //   db.close();
  // }
}

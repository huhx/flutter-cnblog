import 'package:flutter_cnblog/model/read_log.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ReadLogApi {
  final tableName = 'read_log';
  final dbName = 'read_log.db';
  final tableScript = '''
    CREATE TABLE read_log(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      type TEXT NOT NULL,
      startTime INTEGER NOT NULL,
      endTime INTEGER NOT NULL,
      duration INTEGER,
      json TEXT NOT NULL,
      status TEXT NOT NULL,
      createTime INTEGER NOT NULL
    )
  ''';

  Future<void> insert(ReadLog readLog) async {
    final Database db = await _getDB();
    await db.insert(tableName, readLog.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ReadLog>> queryReadLogs(int pageNum, int pageSize) async {
    final Database db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      offset: (pageNum - 1) * pageSize,
      limit: pageSize,
      orderBy: 'createTime desc',
    );
    return maps.map((json) => ReadLog.fromJson(json)).toList();
  }

  Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), dbName),
      onCreate: (db, version) => db.execute(tableScript),
      version: 1,
    );
  }
}

final readLogApi = ReadLogApi();

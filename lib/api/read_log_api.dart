import 'package:flutter_cnblog/model/read_log.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ReadLogApi {
  static const String tableName = 'read_log';
  static const String dbName = 'read_log.db';
  static const String tableScript = '''
    CREATE TABLE read_log(
      id TEXT PRIMARY KEY,
      type TEXT NOT NULL,
      summary TEXT NOT NULL,
      json TEXT NOT NULL,
      status TEXT NOT NULL,
      createTime INTEGER NOT NULL
    )
  ''';

  Future<void> insert(ReadLog readLog) async {
    final Database db = await _getDB();
    await db.insert(tableName, readLog.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> delete(String id) async {
    final Database db = await _getDB();
    await db.rawUpdate('UPDATE read_log SET status = ? where id = ?', [ReadLogStatus.delete.name, id]);
  }

  Future<void> deleteAll() async {
    final Database db = await _getDB();
    await db.rawUpdate('UPDATE read_log SET status = ?', [ReadLogStatus.delete.name]);
  }

  Future<void> clear() async {
    final Database db = await _getDB();
    await db.delete(tableName);
  }

  Future<List<ReadLog>> queryReadLogs(int pageNum) async {
    final Database db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      offset: (pageNum - 1) * 20,
      where: 'status = ?',
      whereArgs: [ReadLogStatus.normal.name],
      limit: 20,
      orderBy: 'createTime desc',
    );
    return maps.map((json) => ReadLog.fromJson(json)).toList();
  }

  Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), dbName),
      onCreate: (db, _) => db.execute(tableScript),
      version: 1,
    );
  }
}

final readLogApi = ReadLogApi();

import 'package:denomination/database/database_constant.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  Database? _database;

  factory DatabaseService() => _instance;

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, DatabaseConstants.dbName);
    return await openDatabase(
      path,
      version: 3,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE ${DatabaseConstants.tableName} (
            ${DatabaseConstants.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${DatabaseConstants.columnTotal} INTEGER,
            ${DatabaseConstants.columnRemark} TEXT,
            ${DatabaseConstants.columnDate} TEXT,
            ${DatabaseConstants.columnCategory} TEXT,
            ${DatabaseConstants.columnCurrencyCount} TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 3) {
          await db.execute('''
            ALTER TABLE ${DatabaseConstants.tableName} 
            ADD COLUMN ${DatabaseConstants.columnRemark} TEXT;
          ''');
          await db.execute('''
            ALTER TABLE ${DatabaseConstants.tableName} 
            ADD COLUMN ${DatabaseConstants.columnDate} TEXT;
          ''');
          await db.execute('''
            ALTER TABLE ${DatabaseConstants.tableName} 
            ADD COLUMN ${DatabaseConstants.columnCategory} TEXT;
          ''');
          await db.execute('''
            ALTER TABLE ${DatabaseConstants.tableName} 
            ADD COLUMN ${DatabaseConstants.columnCurrencyCount} TEXT;
          ''');
        }
      },
    );
  }

  Future<void> insertDenomination(int totalAmount, String remark,
      String category, DateTime date, Map<String, int> currencyCount) async {
    final db = await database;
    await db.insert(
      DatabaseConstants.tableName,
      {
        DatabaseConstants.columnTotal: totalAmount,
        DatabaseConstants.columnRemark: remark,
        DatabaseConstants.columnCategory: category,
        DatabaseConstants.columnDate: date.toIso8601String(),
        DatabaseConstants.columnCurrencyCount: currencyCount.toString(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getDenominations() async {
    final db = await database;
    return await db.query(DatabaseConstants.tableName);
  }

  Future<void> deleteDenominationById(int id) async {
    final db = await database;
    await db.delete(
      DatabaseConstants.tableName,
      where: '${DatabaseConstants.columnId} = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateDenomination(int id, int totalAmount, String remark,
      String category, DateTime date, Map<String, int> currencyCount) async {
    final db = await database;
    await db.update(
      DatabaseConstants.tableName,
      {
        DatabaseConstants.columnTotal: totalAmount,
        DatabaseConstants.columnRemark: remark,
        DatabaseConstants.columnCategory: category,
        DatabaseConstants.columnDate: date.toIso8601String(),
        DatabaseConstants.columnCurrencyCount: currencyCount.toString(),
      },
      where: '${DatabaseConstants.columnId} = ?',
      whereArgs: [id],
    );
  }

  Future<void> clearDenominations() async {
    final db = await database;
    await db.delete(DatabaseConstants.tableName);
  }
}

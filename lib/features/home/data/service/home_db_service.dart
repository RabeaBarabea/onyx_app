import 'package:onyx_task_app/features/home/data/models/bill_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HomeDb {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    final path = join(await getDatabasesPath(), 'bills.db');
    _db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return _db!;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE bills (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        bill_type TEXT,
        bill_no TEXT,
        bill_srl TEXT,
        bill_date TEXT,
        bill_time TEXT,
        bill_amt REAL,
        tax_amt REAL,
        dlvry_amt REAL,
        mobile_no TEXT,
        customer_name TEXT,
        dlvry_status_flg TEXT
      )
    ''');
  }

  Future<void> insertBills(List<BillModel> bills) async {
    final db = await database;
    final batch = db.batch();
    for (final bill in bills) {
      batch.insert(
        'bills',
        bill.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<BillModel>> fetchBills({String? statusFilter}) async {
    final db = await database;
    final result = await db.rawQuery(
      statusFilter != null
          ? 'SELECT * FROM bills WHERE dlvry_status_flg = ?'
          : 'SELECT * FROM bills',
      statusFilter != null ? [statusFilter] : null,
    );
    return result.map((e) => BillModel.fromMap(e)).toList();
  }
}

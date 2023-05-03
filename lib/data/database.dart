import 'package:controle_financeiro/data/dao/gasto_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
 
Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), "fin.db");
  return await openDatabase(path, onCreate: (db, version) async {
    await db.execute(GastoDAO.tableSql);
  },version: 1);
}
import 'package:controle_financeiro/data/component/gasto.dart';
import 'package:controle_financeiro/data/database.dart';
import 'package:sqflite/sqflite.dart' as sql;

class GastoDAO {
  static const String tableName = "gasto";
  static const String tableSql = """CREATE TABLE $tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        valor INTEGER NOT NULL,
        description TEXT,
        categoria TEXT,
        data TEXT,
        ehGasto BOOLEAN NOT NULL
      )
      """;

  save(int valor, String description, String categoria, bool ehGasto, String data) async {

    final sql.Database bancoDeDados = await getDatabase();
    final objectData = {'valor': valor, 'description': description, 'categoria': categoria,'ehGasto': ehGasto,'data': data };
    await bancoDeDados.insert(tableName, objectData, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    
  }
  delete(int id) async {
    final sql.Database bancoDeDados = await getDatabase();
    await bancoDeDados.delete(tableName,where: "id = ?", whereArgs: [id]);
  }

  Future<List<Gasto>> getAll() async {
    final sql.Database bancoDeDados = await getDatabase();
    final data = await bancoDeDados.query(tableName, orderBy: "id");
    return toList(data);
  }

  List<Gasto> toList(List<Map<String, dynamic>> data){
    List<Gasto> listaGastos = [];
    for(Map<String, dynamic> item in data){
      // delete(item['id']);
      listaGastos.add(Gasto(item['id'],item['valor'], item['description'],item['categoria'],item['ehGasto']>0? true: false,item['data']));
      
    }
    return listaGastos;
  }

}

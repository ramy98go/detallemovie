import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:practica1/src/models/profile_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper3{

  static final _nombreBD = "PROFILEBD";
  static final _versionBD = 3;
  static final _nombreTBL = "tblProfile";

  static Database? _database;
  Future<Database?> get database async{
    if(_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaBD = join(carpeta.path,_nombreBD);
    return openDatabase(
        rutaBD,
        version: _versionBD,
        onCreate: _crearTabla
    );
  }

  Future<void> _crearTabla(Database db, int version) async{
    await db.execute("CREATE TABLE $_nombreTBL (id INTEGER PRIMARY KEY, nombre VARCHAR(50), apellidop VARCHAR(50), apellidom VARCHAR(50), telefono VARCHAR(100), email VARCHAR(100), photo VARCHAR(100) )");
  }

  Future<int> insert(Map<String,dynamic> row) async{
    var conexion = await database;
    return conexion!.insert(_nombreTBL, row);
  }

  Future<int> update(Map<String, dynamic> row) async{
    var conexion = await database;
    return conexion!.update(_nombreTBL, row, where: 'id = ?', whereArgs: [row['id']]); //whereArgs: [row['id']]);
  }

  //Future<ProfileModel> getUser(int id) async{
  //  var conexion = await database;
  //  var result = await conexion!.query(_nombreTBL, where: 'id = ?', whereArgs: [id]);
    //result.map((notaMap) => NotasModel.fromMap(notaMap)).first;
 //   return ProfileModel.fromMap(result.first);
 // }

  Future<List<ProfileModel>> getUsers() async{
    var conexion = await database;
    var result = await conexion!.query(_nombreTBL);
    return result.map((notaMap) => ProfileModel.fromMap(notaMap)).toList();
  }

  Future <int> perfilUser(Map<String, dynamic> row) async{
    var conexion = await database;
    var result = await conexion!.query(_nombreTBL);
    if(result.isEmpty){
      return insert(row);
    }
    else{
      var perfilsearch = result.first;
      var perfil = ProfileModel.fromMap(perfilsearch);
      perfil.nombre = row['nombre'];
      perfil.apellidop = row['apellidop'];
      perfil.apellidom = row['apellidom'];
      perfil.telefono = row['telefono'];
      perfil.email = row['email'];
      return update(perfil.toMap());
    }
}

Future<ProfileModel?> getUser() async {
    var conexion = await database;
    var result = await conexion!.query(_nombreTBL);
    return result.isNotEmpty ? ProfileModel.fromMap(result.first) : null;
}

}
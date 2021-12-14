import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:practica1/src/models/movies_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper2 {

  static final _nombreBD = "FAVORITOSBD";
  static final _versionBD = 2;
  static final _nombreTBL = "tblFavoritos";

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
    await db.execute("CREATE TABLE $_nombreTBL (idFavorito INTEGER PRIMARY KEY, idMovie INTEGER, title VARCHAR(60), posterpath VARCHAR(50) )");
  }

  Future<int> insert(Map<String,dynamic> row) async{
    var conexion = await database;
    return conexion!.insert(_nombreTBL, row);
  }

  Future<int> delete (int idMovie) async{
    var conexion = await database;
    return await conexion!.delete(_nombreTBL, where: 'idMovie = ?', whereArgs: [idMovie]);
  }

  Future<List<MoviesModel>> getAllMovies() async{
    var conexion = await database;
    var result = await conexion!.query(_nombreTBL);
    return result.map((notaMap) => MoviesModel.fromMap(notaMap)).toList();
  }

  Future<MoviesModel> getMovie(int id) async{
    var conexion = await database;
    var result = await conexion!.query(_nombreTBL, where: 'idFavorito = ?', whereArgs: [id]);
    //return result.map((notaMap) => MoviesModel.fromMap(notaMap)).first;
    return MoviesModel.fromMap(result.first);
  }




}
import 'package:flutter/cupertino.dart';

class MoviesModel{
  int? idFavorito;
  int? idMovie;
  String? title;
  String? posterpath;

/*NotasModel(int id, String titulo, String detalle){
  this.id = id;
  this.titulo = titulo;
  this.detalle = detalle;
}*/

  MoviesModel({this.idFavorito,this.idMovie,this.title, this.posterpath});

//Map -> Object
  factory MoviesModel.fromMap(Map<String,dynamic> map){
    return MoviesModel(
        idFavorito      :  map['idFavorito'],
        idMovie     :  map['idMovie'],
        title     :  map['title'],
        posterpath :  map['posterpath']
    );
  }

//Object -> Map
  Map<String,dynamic> toMap(){
    return{
      'idFavorito'      : idFavorito,
      'idMovie'     : idMovie,
      'title'     : title,
      'posterpath' : posterpath
    };
  }



}
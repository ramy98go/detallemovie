import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practica1/src/models/popular_movies_model.dart';
import 'package:practica1/src/models/actors_model.dart';


class ApiPopular {
    var actorurl = Uri.parse('https://api.themoviedb.org/3/movie/580489/credits?api_key=45ff6d18046873b3d9506f4af7874b63&language=en-US');
    var URL = Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=45ff6d18046873b3d9506f4af7874b63&language=en-US&page=1');

    Future<List<PopularMoviesModel>?> getAllPopular() async{
      final response = await http.get(URL);
      if( response.statusCode == 200){
          var popular = jsonDecode(response.body)['results'] as List;
          List<PopularMoviesModel> listPopular = popular.map((movie) => PopularMoviesModel.fromMap(movie)).toList();
          return listPopular;
      }else{
        return null;
      }

    }

    Future <List<ActorsModel>?> getActors(int id) async{
      final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/$id/credits?api_key=45ff6d18046873b3d9506f4af7874b63&language=en-US'));
      if( response.statusCode == 200){
        var actors = jsonDecode(response.body)['cast'] as List;
        List<ActorsModel> listActor = actors.map((actor) => ActorsModel.fromMap(actor)).toList();
        return listActor;
      }else{
        return null;
      }
    }

}
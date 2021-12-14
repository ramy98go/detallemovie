import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:practica1/src/models/actors_model.dart';
import 'package:practica1/src/models/popular_movies_model.dart';
import 'package:practica1/src/network/api_popular.dart';
import 'package:practica1/src/utils/color_settings.dart';
import 'package:practica1/src/views/card_popular.dart';

class PopularScreen extends StatefulWidget {

  const PopularScreen({Key? key}) : super(key: key);

  @override
  _PopularScreenState createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {

  ApiPopular? apiPopular;

  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('POPULAR MOVIES'),
        backgroundColor: ColorSettings.colorPrimary,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('ISC. Ramón Gómez'),
              accountEmail: Text('ramon1998pxndx@gmail.com'),
              decoration: BoxDecoration(
                color: ColorSettings.colorPrimary,
              ),
            ),
            ListTile(
              title: Text('MIS PELICULAS FAVORITAS'),
              subtitle: Text('Listado de mis películas Favoritas'),
              leading: Icon(Icons.local_movies),
              trailing: Icon(Icons.chevron_right),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, '/favorite').whenComplete(
                        () { setState( () {} ); }
                );
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder(
          future: apiPopular!.getAllPopular(),
          builder: (BuildContext context, AsyncSnapshot<List<PopularMoviesModel>?> snapshot){
            if(snapshot.hasError){
              return Center(child: Text('Hay un error en la petición'),);
            }else{
              if(snapshot.connectionState == ConnectionState.done){
                return _listPopularMovies(snapshot.data);
              }else{
                return CircularProgressIndicator();
              }
            }
          }
      ),
    );
  }

  Widget _listPopularMovies(List<PopularMoviesModel>? movies){

    return ListView.separated(
        itemBuilder: (context, index){
          PopularMoviesModel popular = movies![index];
          return CardPopularView(popular: popular);
        },
        separatorBuilder: (_, __) => Divider(height: 10,),
        itemCount: movies!.length
    );

  }



}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practica1/src/database/database_helper2.dart';
import 'package:practica1/src/models/actors_model.dart';
import 'package:practica1/src/models/movies_model.dart';
import 'package:practica1/src/network/api_popular.dart';
import 'package:practica1/src/screens/movies_screens/detail_new_movie.dart';
import 'package:practica1/src/screens/movies_screens/detail_new_screen.dart';
import 'package:practica1/src/utils/color_settings.dart';
import 'package:video_player/video_player.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  //late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  late DatabaseHelper2 _databaseHelper;
  late MoviesModel mov;

  ApiPopular? apiPopular;


  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int n = movie['id'];

    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: _databaseHelper.getAllMovies(),
              builder: (BuildContext context, AsyncSnapshot<List<MoviesModel>?> snapshot){
                if(snapshot.hasError){
                  return Center(child: Text('Hay un error en la petición intenta de nuevo'),);
                }else{
                  if(snapshot.connectionState == ConnectionState.done){
                    return _listMovieF(snapshot.data);
                  }else{
                    return Center(child: Text('hola'),);
                  }
                }
              }
          ),
          FutureBuilder(
              future: apiPopular!.getActors(n),
              builder: (BuildContext context, AsyncSnapshot<List<ActorsModel>?> snapshot){
                if(snapshot.hasError){
                  return Center(child: Text('Hay un error en la petición intenta de nuevo'),);
                }else{
                  if(snapshot.connectionState == ConnectionState.done){
                    return _listPopularMovies(snapshot.data);
                  }else{
                    return CircularProgressIndicator();
                  }
                }
              }
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
    _databaseHelper = DatabaseHelper2();
  }

  int cIndex = 0;

  Widget _listMovieF(List<MoviesModel>? data){

    final movie = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int n = movie['id'];

    return Container(
      padding: EdgeInsets.only(left: 270, top: 350),
      child: ListView.builder(
        itemBuilder: (BuildContext context, index) {
          MoviesModel popular = data![index];
          if(popular.idMovie == n)
            {
             cIndex = 1;
            }
          return Container();
        },
        itemCount: data!.length,
      ),
    );
  }

  Widget _listPopularMovies(List<ActorsModel>? actores){

    final movie = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int n = movie['id'];
    int val = 0;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            ClipPath(
              child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: 'https://image.tmdb.org/t/p/w500/${movie['posterpath']}',
                    height: MediaQuery.of(context).size.height/2,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 285, top: 385),
              child: IconButton(
                icon: cIndex == 0 ? Icon(Icons.favorite_border) : Icon(Icons.favorite),
                color: Colors.redAccent,
                iconSize: 50,
                onPressed: () {
                  if(cIndex == 0){
                    MoviesModel savemovie = MoviesModel(
                        idMovie: movie['id'],
                        title: movie['title'] ,
                        posterpath: movie['posterpath']
                    );
                    _databaseHelper.insert(savemovie.toMap()).then(
                            (value) {
                          if (value > 0) {
                            print("Se añadio con exito");
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('La solicitud no se completo'))
                            );
                          }
                        }
                    );
                    setState(() {   });
                  } else {
                    _databaseHelper.delete(n).then(
                            (noRows) {
                          if (noRows > 0) {
                            ScaffoldMessenger.of(
                                context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'El registro se ha eliminado'))
                            );
                          }
                        }

                    );

                    setState(() { cIndex = 0; });
                  }

                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 285, top: 437),
              child: Text(
                'Añadir a Favorito', style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                Container(
                  padding: EdgeInsets.only(top: 241),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text('${movie['title']}'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'multi'
                          ),
                        ),
                        Icon(
                          Icons.play_circle_fill_rounded,
                          color: Colors.redAccent,
                          size: 75,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Descripción: '.toUpperCase())
                            ],
                          ),
                        ),
                        SizedBox(height: 15,),
                        Container(
                          height: 100,
                          child: Text(
                            '${movie['overview']}',
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontFamily: 'multi'),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text('Actores'),
                        SizedBox(height: 5,),
                        Container(
                          height: 110,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) =>
                            VerticalDivider(
                              color: Colors.transparent,
                              width: 5,
                            ),
                            itemCount: actores!.length,
                            itemBuilder: (context, index){
                              ActorsModel popular = actores[index];
                              return Container(
                                child: Column(
                                  children: <Widget>[
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      elevation: 3,
                                      child: ClipRRect(
                                        child: CachedNetworkImage(
                                          imageUrl: popular.profilepath == '' ? 'https://static.thenounproject.com/png/363639-200.png' :
                                          'https://image.tmdb.org/t/p/w500/${popular.profilepath}',
                                          imageBuilder:
                                          (context, imageBuilder){
                                            return Container(
                                              width: 80,
                                                height: 80,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(100)
                                                ),
                                                image: DecorationImage(
                                                  image: imageBuilder,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    )
                ),
              ],
            )
          ],
        ),
      ),
    );

  }



  }






import 'package:flutter/material.dart';
import 'package:practica1/src/database/database_helper2.dart';
import 'package:practica1/src/models/movies_model.dart';

class FavoriteMovieScreen extends StatefulWidget {
  const FavoriteMovieScreen({Key? key}) : super(key: key);

  @override
  _FavoriteMovieScreenState createState() => _FavoriteMovieScreenState();
}

class _FavoriteMovieScreenState extends State<FavoriteMovieScreen> {

  late DatabaseHelper2 _databaseHelper;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _databaseHelper = DatabaseHelper2();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAVORITE MOVIES'),
      ),
      body: FutureBuilder(
        future: _databaseHelper.getAllMovies(),
        builder: (BuildContext context, AsyncSnapshot<List<MoviesModel>> snapshot){
          if(snapshot.hasError ){
            return Center(child: Text('Ocurrio un error en la petición'),);
          }else{
            if(snapshot.connectionState == ConnectionState.done){
              return _listadoMoviesF(snapshot.data!);
            }else{
              return Center(child: CircularProgressIndicator(),);
            }
          }
        },
      ),
    );
  }

  Widget _listadoMoviesF(List<MoviesModel> mov){
    return RefreshIndicator(
        onRefresh: (){
          return Future.delayed(
              Duration(seconds: 2),
                  (){ setState(() {}); }
          );

        },
        child: ListView.separated(
          itemBuilder: (BuildContext context, index){
            MoviesModel movie = mov[index];
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow (
                        color: Colors.black87,
                        offset: Offset(0.0,5.0),
                        blurRadius: 2.5
                    )
                  ]
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Stack(
                    children:[
                      Container(
                        child: FadeInImage(
                          placeholder: AssetImage('assets/activity_indicator.gif'),
                          image: NetworkImage('https://image.tmdb.org/t/p/w500/${movie.posterpath}'),
                          fadeInDuration: Duration(milliseconds: 200),
                        ),
                      ),
                      Opacity(
                        opacity: .5,
                        child: Container(
                          padding: EdgeInsets.only(left: 10.0),
                          height: 55.0,
                          color: Colors.black,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[
                              Text(movie.title!, style: TextStyle(color: Colors.white, fontSize: 12.0),),

                            ],
                          ),
                        ),
                      )
                    ]
                ),
              ),
            );
          },
          separatorBuilder: (_, __) => Divider(height: 15,),
          itemCount: mov.length,
        )

    );
  }


}

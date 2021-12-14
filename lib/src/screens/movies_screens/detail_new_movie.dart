import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:practica1/src/models/actors_model.dart';
import 'package:practica1/src/network/api_popular.dart';
import 'package:practica1/src/screens/movies_screens/detail_screen.dart';
import 'package:practica1/src/utils/color_settings.dart';

class DetailNewMovieScreen extends StatefulWidget {

  const DetailNewMovieScreen({Key? key
  }) : super(key: key);

  @override
  _DetailNewScreenState createState() => _DetailNewScreenState();
}

class _DetailNewScreenState extends State<DetailNewMovieScreen> {

  ApiPopular? apiPopular;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiPopular = ApiPopular();
  }

  @override
  Widget build(BuildContext context) {

    final movie = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int n = movie['id'];


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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                Container(
                  padding: EdgeInsets.only(top: 244),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text('${movie['title']}'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'multi'
                          ),
                        ),
                        Icon(
                          Icons.play_circle_outline_outlined,
                          color: ColorSettings.colorPrimary,
                          size: 75,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5,),
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
                        SizedBox(height: 5,),
                        Container(
                          height: 100,
                          child: Text(
                            '${movie['overview']}',
                          ),
                        ),
                        SizedBox(height: 0,),
                        Text('Actores'),
                        SizedBox(height: 1,),
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
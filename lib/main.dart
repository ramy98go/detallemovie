import 'package:flutter/material.dart';
import 'package:practica1/src/screens/agregar_nota_screen.dart';
import 'package:practica1/src/screens/intenciones_screen.dart';
import 'package:practica1/src/screens/movies_screens/detail_new_screen.dart';
import 'package:practica1/src/screens/movies_screens/detail_screen.dart';
import 'package:practica1/src/screens/movies_screens/favorite_movie_screen.dart';
import 'package:practica1/src/screens/movies_screens/popular_screen.dart';
import 'package:practica1/src/screens/notas_screen.dart';
import 'package:practica1/src/screens/opcion1_screen.dart';
import 'package:practica1/src/screens/splash_screen.dart';
import 'package:practica1/src/screens/profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/opc1'           : (BuildContext context) => Opcion1Screen(),
        '/profile'        : (BuildContext context) => FileScreen(),
        '/intenciones'    : (BuildContext context) => IntencionesScreen(),
        '/notas'          : (BuildContext context) => NotasScreen(),
        '/agregar'        : (BuildContext context) => AgregarNotaScreen(),
        '/movie'          : (BuildContext context) => PopularScreen(),
        '/detail'         : (BuildContext context) => DetailScreen(),
        '/favorite'       : (BuildContext context) => FavoriteMovieScreen()
      },
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:practica1/src/models/actors_model.dart';
import 'package:practica1/src/screens/movies_screens/detail_new_movie.dart';

class DetailNewScreen extends StatelessWidget {
  final ActorsModel actori;
  const DetailNewScreen({Key? key,
    required this.actori
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final movie = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

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
                imageUrl: 'https://image.tmdb.org/t/p/w500/${actori.profilepath}',
                imageBuilder: (context, imageBuilder){
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
                        )
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


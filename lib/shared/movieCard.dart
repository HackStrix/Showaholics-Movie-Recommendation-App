import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';


class movieCard extends StatelessWidget {
  final movies;
  final i;
  var image_url = 'https://image.tmdb.org/t/p/w342/';
  var img_url = "https://image.tmdb.org/t/p/original/";

  movieCard(this.movies, this.i);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width / 2.5,
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
              blurRadius: 5.0, color: Colors.grey[400], offset: Offset(0, 3))
        ],
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: CachedNetworkImage(

                // movieList[id]['img'],
                imageUrl:image_url + movies[i]['poster_path'],
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),

              ),
            ),
          ),
        ],
      ),
    );
  }
}
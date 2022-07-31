import 'package:flutter/material.dart';

class EpisodeRows extends StatelessWidget{

  final movies;
  final i;
  Color mainColor = const Color(0xff3C3261);
  var image_url = 'https://image.tmdb.org/t/p/w200/';
  EpisodeRows(this.movies,this.i);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
          margin: const EdgeInsets.symmetric(vertical: 0,horizontal: 12),
          child: new Container(
            width: MediaQuery.of(context).size.width*1/2.6,
            height: MediaQuery.of(context).size.height/4,
          ),
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(10.0),
            color: Colors.grey,
            image: new DecorationImage(
                image: movies[i]['poster_path']==null?new NetworkImage("https://lh3.googleusercontent.com/proxy/PALtaEeQ72UKHW_rS9QMhzAXT11gV8Ek5L8uKge8QqgyYq0mY_DB6uMQYp4TED2s545nI2AwFp4rDWSWjYDqIeG9rbnloREOyQWL9ZCYkW6vudIJkM4E3QovBW_Q8wyacYf02Z8O5nazOA") :new NetworkImage(
                    image_url + movies[i]['poster_path']),
                fit: BoxFit.cover),
            boxShadow: [
              new BoxShadow(
                  color: mainColor,
                  blurRadius: 5.0,
                  offset: new Offset(2.0, 5.0))
            ],
          ),
        ),
//        new Expanded(
//
//            child: new Container(
//              margin: const      EdgeInsets.fromLTRB(16.0,0.0,16.0,0.0),
//              child: new Column(children: [
//                new Text(
//                  movies[i]['title'],
//                  style: new TextStyle(
//                      fontSize: 20.0,
//                      fontFamily: 'Arvo',
//                      fontWeight: FontWeight.bold,
//                      color: mainColor),
//                ),
//                new Padding(padding: const EdgeInsets.all(2.0)),
//                new Text(movies[i]['overview'],
//                  maxLines: 3,
//                  style: new TextStyle(
//                      color: const Color(0xff8785A4),
//                      fontFamily: 'Arvo'
//                  ),)
//              ],
//                crossAxisAlignment: CrossAxisAlignment.start,),
//            )
//        ),
//        new Container(
//          width: 300.0,
//          height: 0.5,
//          color: const Color(0xD2D2E1ff),
//          margin: const EdgeInsets.all(16.0),
//        )
      ],
    );

  }

}
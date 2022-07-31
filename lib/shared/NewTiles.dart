import 'package:flutter/material.dart';


class MovieCellRect extends StatelessWidget{

  final movies;
  final i;
  Color mainColor = const Color(0xff3C3261);
  var image_url = 'https://image.tmdb.org/t/p/w185';
  MovieCellRect(this.movies,this.i);

  @override
  Widget build(BuildContext context) {
    if (movies[i]["last_air_date"] == null || movies[i]["last_air_date"] == "") {
      movies[i]["last_air_date"] ='2000-04-10';
//      print(movies[i]);
    }
    if (movies[i]["release_date"] == null || movies[i]["release_date"] == "") {
      movies[i]["release_date"] = '2000-04-10';
//      print(movies[i]["last_air_date"]);
//      print(movies[i]);
    }
//    print(movies[i]["release_date"] + "+" + movies[i]["first_air_date"]);
    return new Column(
      children: <Widget>[
        DateTime.now().difference(DateTime.parse(movies[i]["last_air_date"])).inDays<14||DateTime.now().difference(DateTime.parse(movies[i]["release_date"])).inDays<14 && (movies[i]["release_date"]!=null || movies[i]["first_air_date"]!=null)?Banner(
          message: "New",
          location: BannerLocation.topEnd,
          color: Colors.transparent,
          child: new Container(
//            color: Colors.black38,
            margin: const EdgeInsets.symmetric(vertical: 0,horizontal: 0),
            child: new Container(
              width: MediaQuery.of(context).size.width*1/3.2,
              height: MediaQuery.of(context).size.height/4.6,
            ),
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(10.0),
              color: Colors.black38,
              image: new DecorationImage(
                  image: movies[i]['poster_path']==null?new NetworkImage("https://static.thenounproject.com/png/1211233-200.png") :new NetworkImage(
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
        ):ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: new Container(
//            color: Colors.transparent,
            width: MediaQuery.of(context).size.width*1/3.2,
            height: MediaQuery.of(context).size.height/4.6,
            margin: const EdgeInsets.symmetric(vertical: 0,horizontal: 0),
            decoration: new BoxDecoration(
//              borderRadius: new BorderRadius.circular(10.0),
              color: Colors.transparent,
              image: new DecorationImage(
                  image: movies[i]['poster_path']==null?new NetworkImage("https://static.thenounproject.com/png/1211233-200.png") :new NetworkImage(
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
        ),
//
      ],
    );

  }

}
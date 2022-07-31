import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_flix/shared/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

//class tile extends StatefulWidget {
//  final movie;
//  final i;
//  var img_url = "https://image.tmdb.org/t/p/w500/";
//  tile(this.movie,this.i);
//  @override
//  _tileState createState() => _tileState();
//}

//class _tileState extends State<tile> {
//  @override
//  Widget build(BuildContext context) {
//    return InkWell(
//        onTap: () {
////          Navigator.pushNamed(context, MovieCategoryPageArguments.routeName,
////              arguments: MovieCategoryPageArguments(
////                  movies: model.childrenMovies, title: model.title));
//        },
//        child: Card(
//            shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(3.0)),
//            margin: EdgeInsets.fromLTRB(16, 4, 16, 4),
//            child: Container(
//                child: Stack(children: <Widget>[
//                  Align(
//                      alignment: Alignment.centerRight,
//                      child: Container(
//                          width: 180,
//                          child: NetworkImage("https://image.tmdb.org/t/p/w500/$thi"
//                          , fit: BoxFit.cover))),
//                  Align(
//                      alignment: Alignment.center,
//                      child: Container(
//                        decoration: BoxDecoration(
//                            gradient: LinearGradient(
//                                begin: Alignment.centerLeft,
//                                end: Alignment.centerRight,
//                                colors: [Colors.transparent, Colors.grey])),
//                      )),
//                  Container(
//                      padding: EdgeInsets.only(left: 24),
//                      child: Align(
//                          alignment: Alignment.centerLeft,
//                          child: Text(
//                            model.title,
//                            style: TextStyle(
//                                fontSize: 14, fontWeight: FontWeight.bold),
//                          )))
//                ]))));
//  }
//}

//class MovieCell extends StatelessWidget{
//
//  final movies;
//  Color mainColor = const Color(0xff3C3261);
//  var image_url = 'https://image.tmdb.org/t/p/w500/';
//  MovieCell(this.movies);
//
//  @override
//  Widget build(BuildContext context) {
//    return new Column(
//      children: <Widget>[
//        new Row(
//          children: <Widget>[
//            new Padding(
//              padding: const EdgeInsets.all(0.0),
//              child: new Container(
//                margin: const EdgeInsets.all(16.0),
//                child: new Container(
//                  width: 70.0,
//                  height: 70.0,
//                ),
//                decoration: new BoxDecoration(
//                  borderRadius: new BorderRadius.circular(10.0),
//                  color: Colors.grey,
//                  image: new DecorationImage(
//                      image: new NetworkImage(
//                          image_url + movies['poster_path']),
//                      fit: BoxFit.cover),
//                  boxShadow: [
//                    new BoxShadow(
//                        color: mainColor,
//                        blurRadius: 5.0,
//                        offset: new Offset(2.0, 5.0))
//                  ],
//                ),
//              ),
//            ),
//            new Expanded(
//
//                child: new Container(
//                  margin: const      EdgeInsets.fromLTRB(16.0,0.0,16.0,0.0),
//                  child: new Column(children: [
//                    new Text(
//                      movies['title'],
//                      style: new TextStyle(
//                          fontSize: 20.0,
//                          fontFamily: 'Arvo',
//                          fontWeight: FontWeight.bold,
//                          color: mainColor),
//                    ),
//                    new Padding(padding: const EdgeInsets.all(2.0)),
//                    new Text(movies[i]['overview'],
//                      maxLines: 3,
//                      style: new TextStyle(
//                          color: const Color(0xff8785A4),
//                          fontFamily: 'Arvo'
//                      ),)
//                  ],
//                    crossAxisAlignment: CrossAxisAlignment.start,),
//                )
//            ),
//          ],
//        ),
//        new Container(
//          width: 300.0,
//          height: 0.5,
//          color: const Color(0xD2D2E1ff),
//          margin: const EdgeInsets.all(16.0),
//        )
//      ],
//    );
//
//  }
//
//}


//class MovieCell extends StatelessWidget{
//
//  final movies;
//  final i;
//  Color mainColor = const Color(0xff3C3261);
//  var image_url = 'https://image.tmdb.org/t/p/w500/';
//  MovieCell(this.movies,this.i);
//
//  @override
//  Widget build(BuildContext context) {
//    return new Column(
//      children: <Widget>[
//        new Row(
//          children: <Widget>[
//            new Padding(
//              padding: const EdgeInsets.all(0.0),
//              child: new Container(
//                margin: const EdgeInsets.all(16.0),
//                child: new Container(
//                  width: 70.0,
//                  height: 70.0,
//                ),
//                decoration: new BoxDecoration(
//                  borderRadius: new BorderRadius.circular(10.0),
//                  color: Colors.grey,
//                  image: new DecorationImage(
//                      image: new NetworkImage(
//                          image_url + movies[i]['poster_path']),
//                      fit: BoxFit.cover),
//                  boxShadow: [
//                    new BoxShadow(
//                        color: mainColor,
//                        blurRadius: 5.0,
//                        offset: new Offset(2.0, 5.0))
//                  ],
//                ),
//              ),
//            ),
//            new Expanded(
//
//                child: new Container(
//                  margin: const      EdgeInsets.fromLTRB(16.0,0.0,16.0,0.0),
//                  child: new Column(children: [
//                    new Text(
//                      movies[i]['title'],
//                      style: new TextStyle(
//                          fontSize: 20.0,
//                          fontFamily: 'Arvo',
//                          fontWeight: FontWeight.bold,
//                          color: mainColor),
//                    ),
//                    new Padding(padding: const EdgeInsets.all(2.0)),
//                    new Text(movies[i]['overview'],
//                      maxLines: 3,
//                      style: new TextStyle(
//                          color: const Color(0xff8785A4),
//                          fontFamily: 'Arvo'
//                      ),)
//                  ],
//                    crossAxisAlignment: CrossAxisAlignment.start,),
//                )
//            ),
//          ],
//        ),
//        new Container(
//          width: 300.0,
//          height: 0.5,
//          color: const Color(0xD2D2E1ff),
//          margin: const EdgeInsets.all(16.0),
//        )
//      ],
//    );
//
//  }
//
//}


class MovieCell extends StatefulWidget{
  final movies;
  final i;

  MovieCell(this.movies,this.i);

  @override
  _MovieCellState createState() => _MovieCellState();
}

class _MovieCellState extends State<MovieCell> {
  Color mainColor = const Color(0xff3C3261);

  var image_url = 'https://image.tmdb.org/t/p/w185';

  @override
  void initState() {
    getUrl().then((String value) {
      if (value != null){
      setState(() {
        image_url =value;
      });}
//      return null;
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movies[widget.i]["last_air_date"] == null || widget.movies[widget.i]["last_air_date"] == "") {
      widget.movies[widget.i]["last_air_date"] ='2000-04-10';
//      print(movies[i]);
    }
    if (widget.movies[widget.i]["release_date"] == null || widget.movies[widget.i]["release_date"] == "") {
      widget.movies[widget.i]["release_date"] = '2000-04-10';
//      print(movies[i]["last_air_date"]);
//      print(movies[i]);
    }
//    print(image_url);
//    print(movies[i]["release_date"] + "+" + movies[i]["first_air_date"]);
    return new Column(
      children: <Widget>[
        DateTime.now().difference(DateTime.parse(widget.movies[widget.i]["last_air_date"])).inDays<14||DateTime.now().difference(DateTime.parse(widget.movies[widget.i]["release_date"])).inDays<14 && (widget.movies[widget.i]["release_date"]!=null || widget.movies[widget.i]["first_air_date"]!=null)?Banner(
          message: "New",
          location: BannerLocation.topEnd,
          color: Colors.transparent,
          child: new Container(
//            color: Colors.black38,
            margin: const EdgeInsets.symmetric(vertical: 0,horizontal: 0),
            child: new Container(
              width: MediaQuery.of(context).size.width*1/3.2,
              height: MediaQuery.of(context).size.height/4.7,
            ),
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(10.0),
              color: Colors.black38,
              image: new DecorationImage(
                  image: widget.movies[widget.i]['poster_path']==null?new NetworkImage("https://static.thenounproject.com/png/1211233-200.png") :new NetworkImage(
                      image_url + widget.movies[widget.i]['poster_path']),
                  fit: BoxFit.cover),
              boxShadow: [
                new BoxShadow(
                    color: mainColor,
                    blurRadius: 5.0,
                    offset: new Offset(2.0, 2.0))
              ],
            ),
          ),
        ):new Container(
//          color: Colors.transparent,
          width: MediaQuery.of(context).size.width*1/3.2,
          height: MediaQuery.of(context).size.height/4.7,
          margin: const EdgeInsets.symmetric(vertical: 0,horizontal: 0),
//          child: new Container(
//            width: MediaQuery.of(context).size.width*1/3.2,
//            height: MediaQuery.of(context).size.height/4.6,
//          ),

          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(10.0),
            color: Colors.black38,
            image: new DecorationImage(
                image: widget.movies[widget.i]['poster_path']==null?new NetworkImage("https://static.thenounproject.com/png/1211233-200.png") :new NetworkImage(
                    image_url + widget.movies[widget.i]['poster_path']),
                fit: BoxFit.cover),
            boxShadow: [
              new BoxShadow(
                  color: mainColor,
                  blurRadius: 5.0,
                  offset: new Offset(2.0, 2.0))
            ],
          ),
        ),
//
      ],
    );

  }
}
Future<String> getUrl() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String abc = prefs.getString("url");
//  print(abc);
  return abc;
}
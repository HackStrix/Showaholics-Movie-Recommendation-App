import 'package:flutter/material.dart';
import 'package:project_flix/screens/DetailedScreens/MoviesDetailView.dart';
import 'package:project_flix/screens/DetailedScreens/TvShowsDetailView.dart';
import 'package:project_flix/service/api_connect.dart';
import 'package:project_flix/service/api_connect_nowplaying_movies.dart';
//import 'package:project_flix/service/api_connect_popular_movies.dart';
import 'package:project_flix/shared/loading.dart';
import 'package:project_flix/shared/tiles.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var movies;
  var tvShows;
  var limiter = 0;

  void _getDataRecommendedMovie() async {
    var data = await getJson(page: "1",language: "en-US",sortBy: "popularity.desc");
    setState(() {
      tvShows = data['results'];
    });
  }

  void _getDataNowPlaying() async {
    var data = await getJsonNowPlayingovies();
    setState(() {
      movies = data['results'];
    }); }
  @override
  Widget build(BuildContext context) {
    if (limiter<1){
      _getDataNowPlaying();
      _getDataRecommendedMovie();
      setState(() {
        limiter+=1;
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Test"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            setState(() {

            });
          },
        ),
        body: (movies==null && tvShows==null)?Loading():new ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height/3.8,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies!=null? movies.length:0,
                itemBuilder: (BuildContext context, int index) {
                  return new FlatButton(
                    child: new MovieCell(movies, index),
                    padding: const EdgeInsets.all(0.0),
                    color: Colors.white,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MoviesDetailView(movies,index)),);
                    },
                  );
                },
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height/3.8,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tvShows!=null? tvShows.length:0,
                itemBuilder: (BuildContext context, int index) {
                  return new FlatButton(
                    child: new MovieCell(tvShows, index),
                    padding: const EdgeInsets.all(0.0),
                    color: Colors.white,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TvShowsDetailView(tvShows,index)),);
                    },
                  );
                },
              ),
            ),
          ],
        )
    );
  }
}



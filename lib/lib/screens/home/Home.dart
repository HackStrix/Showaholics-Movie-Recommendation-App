import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_flix/screens/DetailedScreens/MoviesDetailView.dart';
import 'package:project_flix/screens/DetailedScreens/TvShowsDetailView.dart';
import 'package:project_flix/service/SeasonEpisodesApi/api_connect_upcoming_episodes.dart';
import 'package:project_flix/service/api_connect.dart';
import 'package:project_flix/service/api_connect_nowplaying_movies.dart';
import 'package:project_flix/shared/NewTiles.dart';
import 'package:project_flix/shared/TitleRow.dart';
import 'package:project_flix/shared/ViewMoreScreen.dart';
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
  var upcoming_tv;
  var trending;

  void _getDataRecommendedMovie() async {
    var data = await getJson(page: "1",language: "en-US",sortBy: "vote_count.desc");
    setState(() {
      tvShows = data['results'];
    });
  }

  void _getDataNowPlaying() async {
    var data = await getJsonNowPlayingovies("1");
    setState(() {
      movies = data['results'];
    }); }
  void _getDataUpcoming() async {
    var data = await getJsonUpcoming();
    setState(() {
      upcoming_tv = data['results'];
    }); }
    void _getDataTrending()async{
    var data = await getJsonTrending();
    setState(() {
      trending = data["results"];
    });
    }
  @override
  Widget build(BuildContext context) {
    if (limiter<1){
      _getDataNowPlaying();
      _getDataRecommendedMovie();
      _getDataUpcoming();
      _getDataTrending();
      setState(() {
        limiter+=1;
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
//          centerTitle: true,
//          backgroundColor: Colors.grey,
//          elevation: 0,
        ),
        body: (movies==null || tvShows==null || upcoming_tv==null || trending == null)?Loading():new ListView(
          children: <Widget>[
//            Padding(
//              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
//              child: Center(child: Text("Home",style: TextStyle(fontSize:30,fontWeight: FontWeight.bold))),
//            ),
//            Divider(),
            TitleRow(title: "Trending"),
            Container(
              height: MediaQuery.of(context).size.height/4.24,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies!=null? movies.length:0,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new FlatButton(
                      child: new MovieCell(trending, index),
                      padding: const EdgeInsets.all(0.0),
                      color: Colors.transparent,
                      onPressed: (){
                        if (trending[index]["media_type"]=="tv"){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TvShowsDetailView(trending,index)),);
                        }
                        else if (trending[index]["media_type"]=="movie"){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MoviesDetailView(trending,index)),);
                        }
                        },
                    ),
                  );
                },
              ),
            ),
            TitleRow(title: "Recent Movies",goto: ViewMoreScreen(mediaType: "movie",case_number: 2,),),
            Container(
              height: MediaQuery.of(context).size.height/4.24,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies!=null? movies.length:0,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new FlatButton(
                      child: new MovieCell(movies, index),
                      padding: const EdgeInsets.all(0.0),
                      color: Colors.transparent,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MoviesDetailView(movies,index)),);
                      },
                    ),
                  );
                },
              ),
            ),
            TitleRow(title: "Popular Shows",goto: ViewMoreScreen(mediaType: "tv",case_number: 3,)),
            Container(
              height: MediaQuery.of(context).size.height/4.24,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tvShows!=null? tvShows.length:0,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new FlatButton(
                      child: new MovieCell(tvShows, index),
                      padding: const EdgeInsets.all(0.0),
                      color: Colors.transparent,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TvShowsDetailView(tvShows,index)),);
                      },
                    ),
                  );
                },
              ),
            ),
            TitleRow(title: "Upcoming Shows",goto: ViewMoreScreen(mediaType: "tv",case_number: 4,)),
            Container(
              height: MediaQuery.of(context).size.height/4.24,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: upcoming_tv!=null? upcoming_tv.length:0,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new FlatButton(
                      child: new MovieCell(upcoming_tv, index),
                      padding: const EdgeInsets.all(0.0),
                      color: Colors.transparent,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TvShowsDetailView(upcoming_tv,index)),);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        )
    );
  }
}



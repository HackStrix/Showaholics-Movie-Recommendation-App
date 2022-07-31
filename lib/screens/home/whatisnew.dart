import 'package:flutter/material.dart';
import 'package:project_flix/service/api_connect.dart';
import 'package:project_flix/service/api_connect_nowplaying_movies.dart';
import 'package:project_flix/service/api_connect_popular_movies.dart';
import 'package:project_flix/shared/loading.dart';
import 'package:project_flix/shared/tiles.dart';
//import 'package:scroll_snap_list/scroll_snap_list.dart';

class whatisnew extends StatefulWidget {
  @override
  _whatisnewState createState() => _whatisnewState();
}

class _whatisnewState extends State<whatisnew> {
  var PopularMovies;
  var RecommendedMovie;
//  int _focusedIndex = 0;
//  var index=0;
  void getDataPopularMovie() async {
    var data = await getJsonPopularMovies();
    setState(() {
      PopularMovies = data['results'];
    });
  }
  void getDataRecommendedMovie() async {
    var data = await getJsonNowPlayingovies();
    setState(() {
      RecommendedMovie = data['results'];
    });
  }
//  void _onItemFocus({int index}) {
//    setState(() {
//      _focusedIndex = index;
//    });
//  }


//  Map movie = {"original_name": "Doctor Who", "genre_ids": [18,10759,10765],"name": "Doctor Who","popularity": 89.94,"origin_country": ["GB"],"vote_count": 1714,"first_air_date": "2005-03-26","backdrop_path": "/nfH8SZJVOxcBlFaqqtoqS5hHizG.jpg","original_language": "en","id": 57243,"vote_average": 7,"overview": "The Doctor is a Time Lord: a 900 year old alien with 2 hearts, part of a gifted civilization who mastered time travel. The Doctor saves planets for a living—more of a hobby actually, and the Doctor's very, very good at it.", "poster_path": "/cDDb7WA2i7cENhkEEjXEDrXGyNL.jpg"};
  @override
  Widget build(BuildContext context) {
    getDataPopularMovie();
    getDataRecommendedMovie();
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title: Text("Home"),
        ),
          body: (PopularMovies==null&&RecommendedMovie==null)? Loading():Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                    itemCount:PopularMovies.length,
                    itemBuilder: (context, i) {
                      return new FlatButton(
                        child: new MovieCell(PopularMovies,i),
                        padding: const EdgeInsets.all(0.0),
                        color: Colors.white,
                      );
                    },
                    ),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:RecommendedMovie.length,
                  itemBuilder: (context, i) {
                    return new FlatButton(
                      child: new MovieCell(RecommendedMovie,i),
                      padding: const EdgeInsets.all(0.0),
                      color: Colors.white,
                    );
                  },
                ),
              ),
            ],
          )
      ),
    );
  }
}

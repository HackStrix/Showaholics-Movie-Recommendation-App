import 'package:flutter/material.dart';
import 'package:project_flix/screens/DetailedScreens/MoviesDetailView.dart';
import 'package:project_flix/screens/DetailedScreens/TvShowsDetailView.dart';
import 'package:project_flix/service/SeasonEpisodesApi/api_connect_upcoming_episodes.dart';
import 'package:project_flix/service/api_connect.dart';
import 'package:project_flix/service/api_connect_nowplaying_movies.dart';
import 'package:project_flix/service/getJsonByGenre.dart';
import 'package:project_flix/shared/loading.dart';
import 'package:project_flix/shared/tiles.dart';
import 'dart:math';


class ViewMoreScreen extends StatefulWidget {
  String mediaType;
  int case_number;
  int genre_id;
  ViewMoreScreen( {this.mediaType,this.case_number,this.genre_id});

  @override
  _ViewMoreScreenState createState() => _ViewMoreScreenState();
}

class _ViewMoreScreenState extends State<ViewMoreScreen> {
  var _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    // set up listener here
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        print("end");
        setState(() {
          page++;
          _getData();
        });
      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
  var page=1;
  var movies;
  var limiter=0;
  var data;
//  void _getDataNowPlaying() async {
//    var data = await getJsonNowPlayingovies(page);
//    setState(() {
//      movies = data['results'] + movies;
//    }); }
  void _getData() async {
    switch (this.widget.case_number){
      case 1:{
        data = await getJsonTrending();
      }
      break;
      case 2:{
        data = await getJsonNowPlayingovies(page.toString());
      }
      break;
      case 3:{
        data = await getJson(page: page.toString(),language: "en-US",sortBy: "vote_count.desc");
      }
      break;
      case 4:{
        data = await getJsonUpcoming();
      }
      break;
      case 5:{
       var mov = await getJsonByGenresMovie(page.toString(), this.widget.genre_id);
       var tivo = await getJsonByGenresTV(page.toString(), this.widget.genre_id);
       for (var i = 0; i < mov['results'].length; i++) {
         mov['results'][i].putIfAbsent("media_type", () => 'movie');
       }
       for (var i = 0; i < tivo['results'].length; i++) {
         tivo['results'][i].putIfAbsent("media_type", () => 'tv');
       }

       var list = await mov['results'] + await tivo['results'];
       // print(mov);
       data = {'results':shuffle(list)};
       // print(data);

      }
    }
    setState(() {
      if (data!=null) {
        if (movies == null)
        {movies = data['results'];}
        else{
          movies = movies+data["results"];
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    if (limiter<1){
      _getData();
      setState(() {
        limiter++;
      });
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body:  movies==null?Loading():Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: new GridView.builder(
              controller: _controller,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,mainAxisSpacing: 20,childAspectRatio: .7,crossAxisSpacing: 5),
              itemCount: movies!=null? movies.length:0,
              itemBuilder: (BuildContext context, int index) {
                return new FlatButton(
                  child: new MovieCell(movies, index),
                  padding: const EdgeInsets.all(0.0),
                  color: Colors.transparent,
                  onPressed: (){
                    if (this.widget.mediaType=="tv") {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TvShowsDetailView(movies,index)),);
                    }
                    else if (this.widget.mediaType == "mixed"){
                      if (movies[index]["media_type"]=="tv"){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TvShowsDetailView(movies,index)),);
                      }
                      else if (movies[index]["media_type"]=="movie"){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MoviesDetailView(movies,index)),);
                      }
                    }
                    else {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MoviesDetailView(movies,index)),);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

List shuffle(List items) {
  var random = new Random();

  // Go through all elements.
  for (var i = items.length - 1; i > 0; i--) {

    // Pick a pseudorandom number according to the list length
    var n = random.nextInt(i + 1);

    var temp = items[i];
    items[i] = items[n];
    items[n] = temp;
  }

  return items;
}

import 'package:add_thumbnail/thumbnail_list_vew.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_flix/screens/DetailedScreens/seasonDetailView.dart';
import 'package:project_flix/service/Database/database.dart';
import 'package:project_flix/service/SeasonEpisodesApi/Seasons_api.dart';
import 'package:project_flix/service/api_connect_similar.dart';
import 'package:project_flix/service/trailers/api_connect_trailers.dart';
import 'package:project_flix/shared/TitleRow.dart';
import 'package:project_flix/shared/loading.dart';
import 'package:project_flix/shared/tiles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TvShowsDetailView extends StatefulWidget {
  final movie;
  final i;
  TvShowsDetailView(this.movie,this.i);
  @override
  _TvShowsDetailViewState createState() => _TvShowsDetailViewState();
}

class _TvShowsDetailViewState extends State<TvShowsDetailView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var posterImageUrl = 'https://image.tmdb.org/t/p/w500';
  Color mainColor = const Color(0xff3C3261);
  var movies;
  List mv;
  bool favourite;
  var uid;
  int limiter = 0;
  var SeasonData;
  var trailer;
  void _similarmovie() async {
    var data = await getJsonSimilar("tv",this.widget.movie[this.widget.i]["id"]);
    print(this.widget.movie[this.widget.i]);
    setState(() {
      movies =  data["results"];
    });
}
  getCurrentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    uid = user.uid;
  }
  Future<void> checkIfFavourite() async {
    var a =  DatabaseService().getDataByQuery(uid);
    a.then((value){
      var x =  value.data;
      setState(() {
        if (x != null){
        mv =  x["tv"];
        if (mv.contains(this.widget.movie[this.widget.i]["id"])){
          favourite = true;
        }
        else{
          favourite = false;
        }}
        //        tvshows = x"[tv"];
      });
    });
  }
  void _seasonInfo() async {
    var data = await getJsonSeasons(this.widget.movie[this.widget.i]["id"]);
    setState(() {
      SeasonData =  data;
    });
//    print(this.widget.movie[this.widget.i]["id"]);
  }
  void _trailerinfo() async {
    var data = await getJsonTrailers(id:this.widget.movie[this.widget.i]["id"],media_type: "tv");
    setState(() {
      var x =  data["results"];
      x.removeWhere((item) => item["key"]==null&& item["site"]!="YouTube");
      trailer = x;
    });
//    print(this.widget.movie[this.widget.i]["id"]);
  }


  @override
  Widget build(BuildContext context) {
    if (limiter<2){
    getCurrentUser();
    checkIfFavourite();
    _similarmovie();
    _seasonInfo();
    _trailerinfo();
    setState(() {
      limiter+=1;
    });}

    return favourite==null?Loading():Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new IconButton(icon:favourite?new Icon(Icons.favorite,color: Colors.red[700],size: 31.0,): new Icon(Icons.favorite_border,size: 28.0,color: Colors.red[700],),
                onPressed: () {
                  setState(()  {
                    favourite = !favourite;
                  });
//                  var firebaseUser = await FirebaseAuth.instance.currentUser();
                  if (favourite==true){
                    mv.addAll([this.widget.movie[this.widget.i]["id"]]);
                    print(mv);
                    Firestore.instance
                        .collection("ids")
                        .document(uid)
                        .updateData({"tv":FieldValue.arrayUnion([this.widget.movie[this.widget.i]["id"]])}).then((_) {
                      print("added_success!");
                    });
                  } else if (favourite==false){
                    mv.remove(this.widget.movie[this.widget.i]["id"]);
                    print(mv);
                    Firestore.instance
                        .collection("ids")
                        .document(uid)
                        .updateData({"tv":FieldValue.arrayRemove([this.widget.movie[this.widget.i]["id"]])}).then((_) {
                      print("remove_success!");
                    });
                  }
                }
            ),
          )
        ],
        iconTheme: IconThemeData(
          color: Colors.black,
          size: 28.0,
        ),
      ),
      body: (this.widget.movie==null && movies == null)?Loading():ListView(
        padding: EdgeInsets.only(top: 0),
        children: <Widget>[
          Container(
            child: this.widget.movie[this.widget.i]["poster_path"]==null?new CachedNetworkImage(imageUrl:"https://static.thenounproject.com/png/1211233-200.png") :CachedNetworkImage(
                imageUrl:posterImageUrl + this.widget.movie[this.widget.i]["poster_path"],
              placeholder: (context, url) => Loading(),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(child: Text(this.widget.movie[this.widget.i]["name"],
              style: TextStyle(
                fontSize: 25,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 5.0,
                    color: Colors.grey,
                    offset: Offset(2,2),
                  ),
                ],
              ),
            )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Row(
              children: <Widget>[
                Text("Status: ",
                  style: TextStyle(
                    fontSize: 16,
//                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                Text(SeasonData["status"],
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(this.widget.movie[this.widget.i]["first_air_date"]),
                Text(this.widget.movie[this.widget.i]["vote_average"].toString()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(this.widget.movie[this.widget.i]["overview"],
              softWrap: true,
              maxLines: 8,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            child: Row(
              children: <Widget>[
                Text("Number Of Seasons: ",
                  style: TextStyle(
                    fontSize: 16,
//                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                Text(SeasonData["number_of_seasons"].toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Row(
              children: <Widget>[
                Text("Total Episodes: ",
                  style: TextStyle(
                    fontSize: 16,
//                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                Text(SeasonData["number_of_episodes"].toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          SeasonData["next_episode_to_air"] == null?SizedBox(): Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Next Episode: ",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text("S",
                      style: TextStyle(
                        fontSize: 16,
//                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                      ),
                    ),

                    Text(SeasonData["next_episode_to_air"]["season_number"].toString(),
                      style: TextStyle(
                        fontSize: 16,
//                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(" E",
                      style: TextStyle(
                        fontSize: 16,
//                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                      ),
                    ),

                    Text(SeasonData["next_episode_to_air"]["episode_number"].toString(),
                      style: TextStyle(
                        fontSize: 16,
//                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 98),
                  child: Row(
                    children: <Widget>[
                      Text("Name: ",
                        style: TextStyle(
                          fontSize: 16,
//                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                        ),
                      ),

                      Text(SeasonData["next_episode_to_air"]["name"].toString(),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 98),
                  child: Row(
                    children: <Widget>[
                      Text("Air Date: ",
                        style: TextStyle(
                          fontSize: 16,
//                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                        ),
                      ),

                      Text(SeasonData["next_episode_to_air"]["air_date"].toString(),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
//                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          TitleRow(title: "Seasons"),
          SeasonData==null?Loading():Container(
            height: MediaQuery.of(context).size.height/3.6,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: SeasonData["seasons"].length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new FlatButton(
                        child: new MovieCell(SeasonData["seasons"], index),
                        padding: const EdgeInsets.all(0.0),
                        color: Colors.transparent,
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SeasonDetail(id:this.widget.movie[this.widget.i]["id"],seasonNumber: SeasonData["seasons"][index]["season_number"],name: SeasonData["seasons"][index]["name"],image:SeasonData["backdrop_path"])));

                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Text(SeasonData["seasons"][index]["name"],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),),
                    )
                  ],
                );
              },
            ),
          ),
          TitleRow(title: "Trailers",),
          trailer==null?Loading(): Container(
            height: MediaQuery.of(context).size.height/3.9,
            width: MediaQuery.of(context).size.width/3.6,
            color: Colors.black38,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: trailer.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      GetTrailerThumbnail(trailer[index]["key"]),
//                      Text(trailer[index]["name"],maxLines: 4,softWrap: true,)
                    ],
                  )
                );
              },
            ),
          ),

          TitleRow(title: "Similar",),
          movies==null?Loading(): Container(
            height: MediaQuery.of(context).size.height/4.24,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new FlatButton(
                    child: new MovieCell(movies, index),
                    padding: const EdgeInsets.all(0.0),
                    color: Colors.transparent,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TvShowsDetailView(movies,index)),);
                    },
                  ),
                );
              },
            ),
          ),
//          Container(
////            width: ,
//            height: 200,
//            width: 100,
////            height:  MediaQuery.of(context).size.height,
//              child: getMediaList("X4bF_quwNtw")),
        ],
      ),
    );
  }
}

Widget GetTrailerThumbnail(String key) {
  return MediaListView(
//    titleTextStyle: TextStyle(color:Colors.black38),
//    titleTextBackGroundColor: Colors.black38,
    overlayChild:Icon(Icons.play_arrow,size: 45,),
    onPressed: (url) {
      print(url);
    },
    urls: "https://www.youtube.com/watch?v=$key",
  );
}
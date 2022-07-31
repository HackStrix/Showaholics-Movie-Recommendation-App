import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_flix/screens/DetailedScreens/TvShowsDetailView.dart';
import 'package:project_flix/service/Database/database.dart';
import 'package:project_flix/service/api_connect_similar.dart';
import 'package:project_flix/service/trailers/api_connect_trailers.dart';
import 'package:project_flix/shared/TitleRow.dart';
import 'package:project_flix/shared/loading.dart';
import 'package:project_flix/shared/tiles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MoviesDetailView extends StatefulWidget {
  final movie;
  final i;
  MoviesDetailView(this.movie,this.i);
  @override
  _MoviesDetailViewState createState() => _MoviesDetailViewState();
}

class _MoviesDetailViewState extends State<MoviesDetailView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var posterImageUrl = 'https://image.tmdb.org/t/p/w500';
  Color mainColor = const Color(0xff3C3261);
  var movies;
  List mv;
  bool favourite;
  var uid;
  int limiter = 0;
  var trailer;
  void _similarmovie() async {
    var data = await getJsonSimilar("movie",this.widget.movie[this.widget.i]["id"]);
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
        mv =  x["movie"];
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
  void _trailerinfo() async {
    var data = await getJsonTrailers(id:this.widget.movie[this.widget.i]["id"],media_type: "movie");
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
                        .updateData({"movie":FieldValue.arrayUnion([this.widget.movie[this.widget.i]["id"]])}).then((_) {
                      print("added_success!");
                    });
                  } else if (favourite==false){
                    mv.remove(this.widget.movie[this.widget.i]["id"]);
                    print(mv);
                    Firestore.instance
                        .collection("ids")
                        .document(uid)
                        .updateData({"movie":FieldValue.arrayRemove([this.widget.movie[this.widget.i]["id"]])}).then((_) {
                      print("remove_success!");
                    });
                  }
                }
            ),
          )
        ],
        iconTheme: IconThemeData(

          color: Colors.orange,
          size: 28.0,
        ),
      ),
      body: (this.widget.movie==null && movies == null)?Loading():ListView(
        padding: EdgeInsets.only(top: 0),
        children: <Widget>[
          Container(
            child: this.widget.movie[this.widget.i]["poster_path"]==null?new CachedNetworkImage(imageUrl:"https://lh3.googleusercontent.com/proxy/PALtaEeQ72UKHW_rS9QMhzAXT11gV8Ek5L8uKge8QqgyYq0mY_DB6uMQYp4TED2s545nI2AwFp4rDWSWjYDqIeG9rbnloREOyQWL9ZCYkW6vudIJkM4E3QovBW_Q8wyacYf02Z8O5nazOA") :CachedNetworkImage(
                imageUrl:posterImageUrl + this.widget.movie[this.widget.i]["poster_path"],
              placeholder: (context, url) => Loading(),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(child: Text(this.widget.movie[this.widget.i]["title"],
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
            padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(this.widget.movie[this.widget.i]["release_date"]),
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
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MoviesDetailView(movies,index)),);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


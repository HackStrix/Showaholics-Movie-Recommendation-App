import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_flix/service/api_connect_similar.dart';
import 'package:project_flix/shared/loading.dart';
import 'package:project_flix/shared/tiles.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TvDetailView extends StatefulWidget {
  final movie;
  final i;
  TvDetailView(this.movie,this.i);
  @override
  _TvDetailViewState createState() => _TvDetailViewState();
}

class _TvDetailViewState extends State<TvDetailView> {

  var posterImageUrl = 'https://image.tmdb.org/t/p/w300';
  Color mainColor = const Color(0xff3C3261);
  var tvshows;
  bool favourite = false;


  void _similarmovie() async {
    var data = await getJsonSimilar("tv",this.widget.movie[this.widget.i]["id"]);

    setState(() {
      tvshows =  data["results"];
    });
  }

  @override
  Widget build(BuildContext context) {
    _similarmovie();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new IconButton(icon:favourite?new Icon(Icons.favorite,color: Colors.red[700],size: 31.0,): new Icon(Icons.favorite_border,size: 28.0,color: Colors.red[700],),
              onPressed: (){
                setState(() {
                  favourite = !favourite;
                });
              },
            ),
          )
        ],
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: (this.widget.movie==null && tvshows == null)?Loading():ListView(
        padding: EdgeInsets.only(top: 0),
        children: <Widget>[

          CachedNetworkImage(
            imageUrl:posterImageUrl + this.widget.movie[this.widget.i]["poster_path"],
            placeholder: (context, url) => Loading(),
            fit: BoxFit.cover,
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
          tvshows==null?Loading(): Container(
            height: MediaQuery.of(context).size.height/3.8,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tvshows.length,
              itemBuilder: (BuildContext context, int index) {
                return new FlatButton(
                  child: new MovieCell(tvshows, index),
                  padding: const EdgeInsets.all(0.0),
                  color: Colors.white,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TvDetailView(tvshows,index)),);
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


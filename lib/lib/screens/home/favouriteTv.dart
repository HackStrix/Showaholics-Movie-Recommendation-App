import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:project_flix/screens/DetailedScreens/MoviesDetailView.dart';
import 'package:project_flix/screens/DetailedScreens/TvShowsDetailView.dart';
import 'package:project_flix/service/Database/database.dart';
import 'package:project_flix/service/api_connect_favourites.dart';
import 'package:project_flix/shared/loading.dart';
import 'package:project_flix/shared/tiles.dart';

class FavouriteTv extends StatefulWidget {
  @override
  _FavouriteTvState createState() => _FavouriteTvState();
}

class _FavouriteTvState extends State<FavouriteTv> {
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var tvShows;
  var limiter = 0;
  var uid;
  var tv;
  var appbar_height = AppBar().preferredSize.height;
  void _getDataFavourites() async {
    await checkIfFavourite();
    if (tv !=null) {
      var data = await getJsonFavouriteTvById(tv.reversed.toList());
      setState(() {
        tvShows = data["results"];
      });
//        print(movies);
    }
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
          tv =  x["tv"];
//          print(mv);
//          if (mv.contains(this.widget.movie[this.widget.i]["id"])){
//            favourite = true;
//          }
//          else{
//            favourite = false;
//          }
        }
        //        tvshows = x"[tv"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (limiter<3){
      getCurrentUser();
//      checkIfFavourite();
      _getDataFavourites();
    setState(() {
      limiter++;
    });
    }
    return Scaffold(
//        appBar: AppBar(
//          title: Text("Favourites"),
//          centerTitle: true,
//        ),

        body: (tvShows==null )?Loading():new ListView(
          children: <Widget>[
//            SizedBox(height: 30.0,),
            Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height-(appbar_height*3+30),
                  child: GridView.builder(
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,mainAxisSpacing: 20,childAspectRatio: .7,crossAxisSpacing: 5),
//                scrollDirection: Axis.horizontal,
                    itemCount: tvShows!=null? tvShows.length:0,
                    itemBuilder: (BuildContext context, int index) {
                      return new FlatButton(
                        child: new MovieCell(tvShows, index),
                        padding: const EdgeInsets.all(0.0),
                        color: Colors.transparent,
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TvShowsDetailView(tvShows,index)),);
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 30.0,)
              ],
            ),
          ],
        )
    );
  }
}

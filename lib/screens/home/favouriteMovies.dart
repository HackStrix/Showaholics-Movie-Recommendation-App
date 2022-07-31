import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_flix/screens/DetailedScreens/MoviesDetailView.dart';
import 'package:project_flix/service/Database/database.dart';
import 'package:project_flix/service/api_connect_favourites.dart';
import 'package:project_flix/shared/loading.dart';
import 'package:project_flix/shared/tiles.dart';

class FavouriteMovies extends StatefulWidget {
  @override
  _FavouriteMoviesState createState() => _FavouriteMoviesState();
}

class _FavouriteMoviesState extends State<FavouriteMovies> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var movies;
  var limiter = 0;
  var uid;
  var mv;
  var appbar_height = AppBar().preferredSize.height;
  void _getDataFavourites() async {
    await checkIfFavourite();
    if (mv !=null) {
      var data = await getJsonFavouriteMovieById(mv.reversed.toList());
      setState(() {
        movies = data["results"];
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
        if (x != null) {
          mv = x["movie"];
        }
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

        body: (movies==null )?Loading():new ListView(
          children: <Widget>[
//            SizedBox(height: 30.0,),
            Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height-(appbar_height*3+30),
                  child: GridView.builder(
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,mainAxisSpacing: 20,childAspectRatio: .7,crossAxisSpacing: 5),
//                scrollDirection: Axis.horizontal,
                    itemCount: movies!=null? movies.length:0,
                    itemBuilder: (BuildContext context, int index) {
                      return new FlatButton(
                        child: new MovieCell(movies, index),
                        padding: const EdgeInsets.all(0.0),
                        color: Colors.transparent,
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MoviesDetailView(movies,index)),);
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_flix/screens/home/subView/my_tvshows.dart';
import 'package:project_flix/service/api_connect.dart';
import 'package:project_flix/shared/loading.dart';
import 'package:project_flix/shared/movieCard.dart';
import 'package:project_flix/shared/section_container.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_flix/service/Database/database.dart';


class myflix extends StatefulWidget {

  @override
  _myflixState createState() => _myflixState();
}

class _myflixState extends State<myflix> {
  var movies;
  var tvshows;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var uid;
  getCurrentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    uid = user.uid;

  }


  @override
  Widget build(BuildContext context) {
    getCurrentUser();
//    getData();
    var a = DatabaseService().getDataByQuery(uid);
    a.then((value){
      var x = value.data;
      setState(() {
        movies = x["movie"];
        tvshows = x["tv"];
      });
      print(movies);
      print(tvshows);
    });

//    return StreamProvider<QuerySnapshot>.value(
//      value: DatabaseService().ids,
//      child:
       return Scaffold(
        appBar: AppBar(
          title: Text(movies[0].toString()),
        ),
    );
  }
}
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_flix/screens/DetailedScreens/MoviesDetailView.dart';
import 'package:project_flix/service/api_connect.dart';
import 'package:project_flix/shared/loading.dart';
import 'package:project_flix/shared/tiles.dart';
import 'package:provider/provider.dart';
import 'package:project_flix/service/Database/database.dart';

class myTvShows extends StatefulWidget {
  @override
  _myTvShowsState createState() => _myTvShowsState();
}

class _myTvShowsState extends State<myTvShows> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var uid;
  getCurrentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    uid = user.uid;

  }

  @override
  Widget build(BuildContext context) {
    getCurrentUser();
//    final idcollection = Provider.of<QuerySnapshot>(context);
//    print(idcollection.documents);

    var movie;
    var movies;
//    void _list(){
//    var doc = idcollection.documents;
//    for (var doc in doc){
//    if (doc.documentID == "$uid"){
//        for (var id in doc.data["movie"]){
//          movie = id;
//        }
//    }
//    }
//    }

    void _getDataNowPlaying() async {
      var data = await getJsonbyid(movie[0]);
      setState(() {
        movies = data['results'];
      }); }

    
    return movies==null?Loading():ListView(
      children: <Widget>[
        Container(
            height: MediaQuery.of(context).size.height/3.8,
            child: ListView.builder(
            itemCount: 1,
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
          )
        ),
      ],
    );
  }
}

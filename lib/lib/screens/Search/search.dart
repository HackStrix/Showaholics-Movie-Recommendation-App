import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_flix/screens/DetailedScreens/MoviesDetailView.dart';
import 'package:project_flix/screens/DetailedScreens/TvShowsDetailView.dart';
import 'package:project_flix/screens/Search/genre.dart';
import 'package:project_flix/service/api_connect_nowplaying_movies.dart';
import 'package:project_flix/service/api_connect_popular_movies.dart';
import 'package:project_flix/service/search_api/api_connect_search.dart';
import 'package:project_flix/shared/loading.dart';
import 'package:project_flix/shared/tiles.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {
            showSearch(context: context, delegate: DataSearch());
          },)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: GenreWidget()
      ),
    );
  }
}


class DataSearch extends SearchDelegate<Future<String>>{
  // ignore: non_constant_identifier_names
  var ImagePath = "https://image.tmdb.org/t/p/w92/";
//  var recents = [];
  List result;
  Future<List> getdata(String query)async{
    var data = await getJsonSearch(query);
      if (data !=null) {var a = data["results"];
      a.removeWhere((item) => item["media_type"] == "person");
      result = a;
      }
  }
//  Future<List> filter()async{
//    var results = [];
//    for (var i=0; i <= result.length;i++){
//      if (result[i]["media_type"] == "tv" || result[i]["media_type"] == "movie"){
//         results += result[i];
//      }
//    }
//    return results;
//  }
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return[
      IconButton(icon: Icon(Icons.clear), onPressed: (){
        query = "";
      })
    ];
//    throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
      close(context, null);
    },);
//    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context)  {
    // TODO: implement buildResults
    if (result!=null) {
      final suggestionList = result;
        return GridView.builder(gridDelegate:  new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,mainAxisSpacing: 20,childAspectRatio: .7,crossAxisSpacing: 5),
            itemCount: suggestionList!=null? suggestionList.length:0,
            itemBuilder: (BuildContext context, int index) {
              return new FlatButton(
                child: new MovieCell(suggestionList, index),
                padding: const EdgeInsets.all(0.0),
                color: Colors.transparent,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) {
                        if (suggestionList[index]["media_type"]=="tv") {
                          return TvShowsDetailView(suggestionList, index);
                        }
                        else {
                          return MoviesDetailView(suggestionList,index);
                        }
                      }),);
                },
              );
            }
        );

          }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    getdata(query);
    if (result!=null) {
      final suggestionList = result;
      return ListView.builder(itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 1.0),
          child: ListTile(
            leading: suggestionList[index]["backdrop_path"]!=null?Image.network(ImagePath+suggestionList[index]["backdrop_path"]):CachedNetworkImage(imageUrl: "https://static.thenounproject.com/png/1211233-200.png",),
            title:suggestionList[index]["name"]!=null?Text(suggestionList[index]["name"]):Text(suggestionList[index]["title"]),
            subtitle: suggestionList[index]["first_air_date"]!=null?Text(suggestionList[index]["first_air_date"]):Text(suggestionList[index]["release_date"]),
            onTap: (){
            if (suggestionList[index]["media_type"]=="tv"){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TvShowsDetailView(suggestionList,index)),);
//            recents+=suggestionList[index];
            }
            else if (suggestionList[index]["media_type"]=="movie"){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MoviesDetailView(suggestionList,index)),);
//            recents+=suggestionList[index];
            }
            },
      ),
        );
      },
          itemCount: suggestionList.length);
    }
    else {

      return Center(child: Text("MyFlix",style: TextStyle(
        fontStyle: FontStyle.italic,
        fontSize: 30
      ),));
    }
//    throw UnimplementedError();
  }
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: theme.primaryColor,
      primaryIconTheme: theme.primaryIconTheme,
      primaryColorBrightness: theme.primaryColorBrightness,
      primaryTextTheme: theme.primaryTextTheme,
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_flix/service/SeasonEpisodesApi/Seasons_api.dart';
import 'package:project_flix/shared/loading.dart';

class SeasonDetail extends StatefulWidget {
  final id;
  final seasonNumber;
  final name;
  final image;
  SeasonDetail({this.id,this.seasonNumber,this.name,this.image});
  @override
  _SeasonDetailState createState() => _SeasonDetailState();
}

class _SeasonDetailState extends State<SeasonDetail> {
  var raw_episodes;
  var episodes;
  var limiter = 0;
  var img_url = "https://image.tmdb.org/t/p/w92/";
  void _getEpisodes() async {
    var data = await getJsonEpisodes(this.widget.id,this.widget.seasonNumber);
    setState(() {
      raw_episodes = data;
      episodes =  data["episodes"];
    });
//    print(episodes);
  }
  @override
  Widget build(BuildContext context) {
    if (limiter<1){
      _getEpisodes();
      setState(() {
        limiter+=1;
      });
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        elevation: 0,
        title: Text(this.widget.name),
      ),
      body: episodes==null?Loading():Column(
//        padding: EdgeInsets.only(top:0),
        children: <Widget>[
//          CachedNetworkImage(
//            imageUrl: "https://image.tmdb.org/t/p/w500/" + this.widget.image,
//            fit: BoxFit.fill,
//          ),
//          Padding(
//            padding: const EdgeInsets.all(16.0),
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Text(this.widget.name,style: TextStyle(fontSize: 25,fontStyle: FontStyle.italic,color: Colors.redAccent),maxLines: 3,),
//                Padding(
//                  padding: const EdgeInsets.symmetric(vertical: 16),
//                  child: Text(raw_episodes["overview"]),
//                )
//              ],
//            ),
//
//          ),
          Container(
            padding: EdgeInsets.all(12.0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
                itemCount: episodes.length,
                itemBuilder: (BuildContext context, int index){
//                  return new FlatButton(
//                    child: Column(
//                      children: <Widget>[
//                        new Row(
//                          children: <Widget>[
//                            CachedNetworkImage(imageUrl: img_url + episodes[index]["still_path"],fit: BoxFit.fitHeight,),
//                            Text(episodes[index]["name"])
//                          ],
//                        ),
//                        Divider()
//                      ],
//                    ),
//
//                  );
                return new Card(
                  shadowColor: Colors.grey[900],
                  color: Colors.grey[100],
                  child: new ListTile(
                    leading: episodes[index]["still_path"]==null?new CachedNetworkImage(imageUrl: "https://lh3.googleusercontent.com/proxy/PALtaEeQ72UKHW_rS9QMhzAXT11gV8Ek5L8uKge8QqgyYq0mY_DB6uMQYp4TED2s545nI2AwFp4rDWSWjYDqIeG9rbnloREOyQWL9ZCYkW6vudIJkM4E3QovBW_Q8wyacYf02Z8O5nazOA"):new CachedNetworkImage(imageUrl: img_url + episodes[index]["still_path"],),
                    title:Text(episodes[index]["name"]),
                    subtitle: Text("Episode " + episodes[index]["episode_number"].toString()),
                    trailing: Icon(Icons.navigate_next),
                    onTap: (){

                    },
                    dense: true,
                  ),
                );
                }
            )
          )
        ],
      )
    );
  }
}

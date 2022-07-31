import 'package:flutter/material.dart';
import 'package:project_flix/service/getJsonByGenre.dart';
import 'package:project_flix/shared/ViewMoreScreen.dart';

class GenreWidget extends StatefulWidget {

  GridViewState createState() => GridViewState();

}

class GridViewState extends State<GenreWidget> {
  var appbar_height = AppBar().preferredSize.height;

  List genres = [[28,"Action"],[12,"Adventure"],[16,"Animation"],[35,"Comedy"],[80,"Crime"],[99,"Documentary"],[18,"Drama"],[10751,"Family"],[14,"Fantasy"],[36,"History"],[27,"Horror"],[10765,"Sci-Fi & Fantasy"],[10402,"Music"],[9648,"Mystery"],[10749,"Romance"],[878,"ScienceFiction"],[53,"Thriller"],[10759, "Action & Adventure"],[10752,"War"],[37,"Western"],[10768,"War & Politics"],[ 10763, "News"],];

  List genres1 = [
  [10759, "Action & Adventure"],
  [16,"Animation"],
  [35,"Comedy"],
  [80,"Crime"],
  [99,"Documentary"],
  [18, "Drama"],
  [10751,"Family"],
  [10762, "Kids"],
  [9648, "Mystery"],
  [ 10763, "News"],
  [10764,"Reality"],
  [10765,"Sci-Fi & Fantasy"  ],
  [10766,"Soap"],
  [10767,"Talk"],
  [10768,"War & Politics"],
  [37,"Western"]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(
//          title: Text("Favourites"),
//          centerTitle: true,
//        ),

        body:  Container(
              height: MediaQuery.of(context).size.height - (appbar_height+20),
              child: GridView.builder(
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,mainAxisSpacing: 8,childAspectRatio: 2.2,crossAxisSpacing: 5),
//                scrollDirection: Axis.horizontal,
                itemCount: genres.length,
                itemBuilder: (BuildContext context, int index) {
                  return new FlatButton(
                    child:  Container(
                        margin:EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        color: Colors.redAccent,
                        child: Center(
                            child: Text(genres[index][1].toString(),
                                style: TextStyle(fontSize: 18, color: Colors.white),
                                textAlign: TextAlign.center)
                        )),
                    padding: const EdgeInsets.all(0.0),
                    color: Colors.transparent,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ViewMoreScreen(mediaType: "mixed",case_number: 5,genre_id: genres[index][0],)));
                    },
                  );
                },
              ),
            ),
        );
  }
  }
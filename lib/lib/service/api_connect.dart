import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

  Future<Map> getJson({String sortBy="release_date.asc",String language="en-US",String page="1"}) async {
    final String api_key = "b268f451fd4ba4b5d3c184332ce44b61";
    var url = "https://api.themoviedb.org/3/discover/tv?api_key=$api_key&page=$page&language=$language&sort_by=$sortBy&timezone=America%2FNew_York&with_original_language=en";
//   var test_url = "https://api.themoviedb.org/3/discover/movie?api_key=$api_key&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var movie = await convert.jsonDecode(response.body);
//      print(movie);
      return movie;
    }
  }

Future<Map> getJsonTrending() async {
  final String api_key = "b268f451fd4ba4b5d3c184332ce44b61";
  var url = "https://api.themoviedb.org/3/trending/all/day?api_key=$api_key";
  //   var test_url = "https://api.themoviedb.org/3/discover/movie?api_key=$api_key&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page";
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var movie = await convert.jsonDecode(response.body);
//      print(movie);
    return movie;
  }
}


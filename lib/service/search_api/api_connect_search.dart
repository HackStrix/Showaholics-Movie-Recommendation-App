import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

  Future<Map> getJsonSearch(String query) async {
    final String api_key = "b268f451fd4ba4b5d3c184332ce44b61";
    var url = "https://api.themoviedb.org/3/search/multi?api_key=$api_key&language=en-US&query=$query&page=1&include_adult=false";
//   var test_url = "https://api.themoviedb.org/3/discover/movie?api_key=$api_key&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var movie = await convert.jsonDecode(response.body);
//      print(movie);
      return movie;
    }
  }


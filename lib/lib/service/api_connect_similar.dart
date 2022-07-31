import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

  Future<Map> getJsonSimilar(String tvOrMovie,int id) async {
    final String api_key = "b268f451fd4ba4b5d3c184332ce44b61";
    String idStr = id.toString();
    var url="https://api.themoviedb.org/3/movie/$idStr/similar?api_key=$api_key&language=en-US&page=1";
//    var url = "https://api.themoviedb.org/3/tv/$idStr/similar?api_key=$api_key&language=en-US&page=1";
    if (tvOrMovie=="tv"){
      url = "https://api.themoviedb.org/3/tv/$idStr/similar?api_key=$api_key&language=en-US&page=1";
    }

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var movie = await convert.jsonDecode(response.body);
//      print(movie);
      return movie;
    }
  }

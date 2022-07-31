import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

  Future<Map> getJsonPopularMovies() async {
    final String api_key = "b268f451fd4ba4b5d3c184332ce44b61";
    var url="https://api.themoviedb.org/3/movie/popular?api_key=$api_key&language=en-US&page=1";
    //    var test_url = "https://api.themoviedb.org/3/discover/tv?api_key=b268f451fd4ba4b5d3c184332ce44b61&language=en-US&sort_by=popularity.desc&air_date.gte=2020-07-10&page=1&timezone=America%2FNew_York&include_null_first_air_dates=false&with_original_language=en";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var movie = await convert.jsonDecode(response.body);
//      print(movie);
      return movie;
    }
  }

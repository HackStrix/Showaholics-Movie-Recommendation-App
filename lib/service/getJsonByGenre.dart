import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

Future<Map> getJsonByGenresMovie(String page, int genre_id) async {
  final String api_key = "b268f451fd4ba4b5d3c184332ce44b61";
  var url_movie="https://api.themoviedb.org/3/discover/movie?api_key=$api_key&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page&with_genres=$genre_id";
  //    var test_url = "https://api.themoviedb.org/3/discover/tv?api_key=b268f451fd4ba4b5d3c184332ce44b61&language=en-US&sort_by=popularity.desc&air_date.gte=2020-07-10&page=1&timezone=America%2FNew_York&include_null_first_air_dates=false&with_original_language=en";
  // var url_tv ="https://api.themoviedb.org/3/discover/tv?api_key=$api_key&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page&with_genres=$genre_id";

  var response_movie = await http.get(url_movie);
  // var response_tv = await http.get(url_tv);

  if (response_movie.statusCode == 200 ) {
    var movie = await convert.jsonDecode(response_movie.body);
    // var tv = await convert.jsonDecode(response_tv.body);
    // var mixed = movie['results'] + tv['results'];
    return movie;
  }
}
Future<Map> getJsonByGenresTV(String page, int genre_id) async {
  final String api_key = "b268f451fd4ba4b5d3c184332ce44b61";
  // var url_movie="https://api.themoviedb.org/3/discover/movie?api_key=$api_key&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page&with_genres=$genre_id";
  //    var test_url = "https://api.themoviedb.org/3/discover/tv?api_key=b268f451fd4ba4b5d3c184332ce44b61&language=en-US&sort_by=popularity.desc&air_date.gte=2020-07-10&page=1&timezone=America%2FNew_York&include_null_first_air_dates=false&with_original_language=en";
  var url_tv ="https://api.themoviedb.org/3/discover/tv?api_key=$api_key&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page&with_genres=$genre_id";

  // var response_movie = await http.get(url_movie);
  var response_tv = await http.get(url_tv);

  if ( response_tv.statusCode == 200) {
    // var movie = await convert.jsonDecode(response_movie.body);
    var tv = await convert.jsonDecode(response_tv.body);
    // var mixed = movie['results'] + tv['results'];
    return tv;
  }
}
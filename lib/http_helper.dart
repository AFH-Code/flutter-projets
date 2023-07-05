import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'dart:convert';
import 'movie.dart';

class HttpHelper {
  final String urlBase = 'api.themoviedb.org';
  final String uriUpcoming = '3/movie/upcoming';
  final String urlSearchBase = '3/search/movie';

  final queryParameters = {
    'api_key': 'c2c55ecb6a296a72c90e8127c902e195',
    'language': 'en-US',
  };

  Future<String> getUpcoming() async {
    Uri url = Uri.https(urlBase, uriUpcoming, queryParameters);
    http.Response result = await http.get(url);

    log(url.toString());
    if (result.statusCode == HttpStatus.ok) {
      String responseBody = result.body;
      return responseBody;
    }
    else {
      return 're';
    }
  }

  Future<List<Movie>> getUpcoming2() async {
    Uri url = Uri.https(urlBase, uriUpcoming, queryParameters);
    http.Response result = await http.get(url);

    log(url.toString());
    List<Movie> movies = [];
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      List moviesMap = jsonResponse['results'];
      movies = moviesMap.map((i) => Movie.fromJson(i)).toList();

      }
      return movies;
  }

  Future<List<Movie>> findMovies(String? title) async {

    Uri url = Uri.https(urlBase, urlSearchBase, {
      'api_key': 'c2c55ecb6a296a72c90e8127c902e195',
      'query': title,
    });
    http.Response result = await http.get(url);

    log(url.toString());
    List<Movie> movies = [];

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      List moviesMap = jsonResponse['results'];
      movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    }
    return movies;
  }

}
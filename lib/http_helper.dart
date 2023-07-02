import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:developer';

class HttpHelper {
  final String urlBase = 'api.themoviedb.org';
  final String uriUpcoming = '3/movie/upcoming';

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

}
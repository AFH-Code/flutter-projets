import 'package:flutter/material.dart';
import 'http_helper.dart';
import 'movie.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {

  String result = '';
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage = 'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

  @override
  void initState() {
    initialize();
    super.initState();
  }


  Future<List<Movie>> initialize() async {
    HttpHelper helper = HttpHelper();
    List<Movie> movies = await helper.getUpcoming2();
    return movies;
  }

    @override
  Widget build(BuildContext context) {
    /*HttpHelper helper = HttpHelper();
    helper.getUpcoming().then(
            (value){
          setState(() {
            result = value;
          });
        }
    );*/
      NetworkImage image;
    return Scaffold(
        appBar: AppBar(title: Text('Movies')),
        /*body: Container(
            child: Text(result)
        )*/

      body: Container(
        child: FutureBuilder(
            future: initialize(),
            builder: (BuildContext context, AsyncSnapshot<List<Movie>> movies) {
              return ListView.builder(
                itemCount: movies.data?.length ?? 0,
                itemBuilder: (BuildContext context, int position) {

                  if (movies.data![position].posterPath != null) {
                    image = NetworkImage(
                        iconBase + (movies.data![position].posterPath ?? '')
                    );
                  }
                  else {
                    image = NetworkImage(defaultImage);
                  }

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: image,
                    ),
                    title: Text(movies.data![position].title ?? ''),
                    subtitle: Text('Released: '+(movies.data![position].releaseDate ?? '')+' - Vote: '+movies.data![position].toString()),
                  );
                }
            );
          }
        )
      )
    );
  }
}
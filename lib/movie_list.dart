import 'package:flutter/material.dart';
import 'http_helper.dart';
import 'movie.dart';
import 'movie_detail.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {

  String result = '';
  String searchKey = '';
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage = 'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
  Icon visibleIcon = Icon(Icons.search);
  Widget searchBar= Text('Movies');

  @override
  void initState() {
    initialize(searchKey);
    super.initState();
  }


  Future<List<Movie>> initialize(String? title) async {
    HttpHelper helper = HttpHelper();
    if (this.visibleIcon.icon == Icons.search) {
      List<Movie> movies = await helper.getUpcoming2();
      return movies;
    }else{
      List<Movie> movies = await helper.findMovies(title);
      setState(() {
        searchKey = title ?? '';
      });
      return movies;
    }
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
        appBar: AppBar(title: searchBar,
            actions: <Widget>[
              IconButton(
                  icon: visibleIcon,
                  onPressed: () {
                    setState(() {
                      if (this.visibleIcon.icon == Icons.search) {
                        this.visibleIcon = Icon(Icons.cancel);
                        this.searchBar = TextField(
                              textInputAction: TextInputAction.search,
                              style: TextStyle(color: Colors.white, fontSize: 20.0),
                              onSubmitted: (String text) {
                                initialize(text);
                              },
                          autofocus: true,
                         );
                      } else {
                        setState(() {
                          this.visibleIcon = Icon(Icons.search);
                          this.searchBar= Text('Movies');
                          searchKey = '';
                        });
                      }
                    }
                    );
                  },
              ),
            ]
        ),
        /*body: Container(
            child: Text(result)
        )*/
      body: Container(
        child: FutureBuilder(
            future: initialize(searchKey),
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
                    onTap: () {
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (_) => MovieDetail(movie: movies.data![position]));
                      Navigator.push(context, route);
                    },
                  );
                }
            );
          }
        )
      )
    );
  }
}
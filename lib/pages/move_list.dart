//MI2F -> Muslimatul Rizki Aulia
//2031710076

import 'package:flutter/material.dart';
import 'package:http_request_api/service/http_service.dart';
import 'package:http_request_api/pages/movie_detail.dart';
import 'package:http_request_api/models/movie.dart';

class MovieList extends StatefulWidget {
  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  late int moviesCount = 0;
  late List movies;
  late HttpService service;
  final String imgPath = 'https://image.tmdb.org/t/p/w500/';

  Future initialize() async {
    movies = [];
    movies = (await service.getPopularMovies())!;
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  @override
  void initState() {
    service = HttpService();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Popular Movies - (Muslimatul R A -> 2031710076)"),
        ),
        body: ListView.builder(
          itemCount: (moviesCount == null) ? 0 : moviesCount,
          itemBuilder: (context, int position) {
            return Card(
              color: Color.fromARGB(255, 231, 178, 178),
              elevation: 3.0,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage(imgPath + movies[position].posterPath),
                ),
                title: Text(movies[position].title),
                subtitle: Text(
                  'Rating = ' + movies[position].voteAverage.toString(),
                ),
                onTap: () {
                  MaterialPageRoute route = MaterialPageRoute(
                      builder: (_) => MovieDetail(movies[position]));
                  Navigator.push(context, route);
                },
              ),
            );
          },
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:netwish/types/movie.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold (
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon (Icons.arrow_back),
          onPressed: () {
            Navigator.pop (context);
          },
        ),
        title: Text(
          movie.title ?? 'Movie Title'
        ), 
      ),
      body: Column (
        children: [
          Expanded (
            child: Image.network( movie.posterPath != null ?
              'https://image.tmdb.org/t/p/w200/${movie.posterPath}': "https://picsum.photos/300/300",
              fit: BoxFit.cover,
            ),
          ), 
          Padding (
            padding: const EdgeInsets.all(8.0),
            child: Text(
             movie.overview ?? 'Movie overview',
            style: const TextStyle (fontSize: 20.0),
            ), // Text
          ),
          Padding (
            padding: const EdgeInsets.all(8.0),
            child: Text(
            movie.releaseDate ?? 'Release date: 2021-01-01',
            style: const TextStyle (fontSize: 20.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Vote average : ${movie.voteAverage ?? "No vote average"}',
              style: const TextStyle (fontSize: 20.0),
            ),
          ),
        ]
      )
    );
  }
}
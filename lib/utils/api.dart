
import 'dart:convert';
import 'package:netwish/types/movie.dart';
import 'package:http/http.dart' as http;

final base_url = 'https://api.themoviedb.org/3/';
final api_key = '26a145d058cf4d1b17cbf084ddebedec';

Future<List<Movie>> getMovies(String movieName) async {
  var query = '';
  if (movieName.isNotEmpty) {
  //Si movieName n'est pas vide, on récupère les films correspondant à la recherche
  // On enleve les espaces dans la recherche
  movieName = movieName.replaceAll(' ', '+');
  query =
    '${base_url}/search/movie?api_key=$api_key&query=$movieName&language=fr-FR&page=1';

  } else {
    query = '${base_url}movie/popular?api_key=$api_key&language=fr-FR&page=1';

  }

  final response = await http.get(Uri.parse(query));

  if (response.statusCode == 200) {
    final result = jsonDecode (response.body);
    final List<Movie> movies = [];
    for (var movie in result['results']) {
      movies.add(Movie(
        title: movie['title'],
        overview: movie ['overview'],
        releaseDate: movie['release_date'],
        posterPath: movie ['poster_path'],
        voteAverage: movie['vote_average'].toDouble(),  
      ));
    }
    return movies;
  } else {
    throw Exception('Failed to load movies');
  }
}
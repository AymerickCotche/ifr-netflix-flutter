import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:netwish/types/movie.dart';
import 'package:netwish/utils/api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Movie> _movies = [];

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final TextEditingController _searchController = TextEditingController();
    return Scaffold (
      appBar: AppBar (
        elevation: 5.0,
        title: const Text(
          'Netflix',
          style: TextStyle (color: Colors.red),
        ), 
        leading: Padding (
          padding: const EdgeInsets.all (4.0),
          child: Image.asset('assets/netflix_logo.png'),
        ), 
        actions: <Widget> [
          IconButton(
            icon: const Icon (Icons.search),
            onPressed: () {
              Alert(
                context: context,
                title: "Search",
                style: const AlertStyle(
                  titleStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 20.0,
                  ),
                  backgroundColor: Colors.black,
                ),
                content: TextField(
                decoration: const InputDecoration (
                  icon: Icon(Icons.search),
                  labelText: 'Name of the movie'
                ),
                controller:
                _searchController,
                 ),
                buttons: [
                DialogButton(
                  onPressed: () {
                    getMovies(_searchController.text).then((value) => {
                      setState(() {
                        _movies = value;
                        _searchController.clear();
                      })
                    });
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Search",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                )
                
                ]).show();
            },
          ), 
        ],
      ),
      body: ListView(
        children: [

          for (var movie in _movies)

            GestureDetector(
              onTap: () => {
                Navigator.pushNamed(context, '/movie',
                  arguments: 
                    movie
                )
              },
              child: Card(
                elevation: 5.0,
                child: Image.network( movie.posterPath != null ? 
                  "https://image.tmdb.org/t/p/w500${movie.posterPath}" : "https://picsum.photos/300/300",
                ), 
              ),
            ),
        ]
      )
    );
  }
}
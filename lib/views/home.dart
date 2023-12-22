import 'package:flutter/material.dart';
import 'package:flutter_movies/constants/app_theme.dart';
import 'package:flutter_movies/models/movie.dart';
import 'package:flutter_movies/services/movie_service.dart';
import 'package:flutter_movies/widgets/now_playing_movie_card.dart';
import 'package:flutter_movies/widgets/trending_movie_card.dart';
import 'package:flutter_movies/widgets/bottom_navigation.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Movie> _movies = [];
  final _movieService = MovieService();
  Future<void> getMovies({int page = 1, String? query}) async {
    final movies = await _movieService.getByPageAndQuery(page: page, query: query);
    print(movies);
    setState(() {
      _movies = movies;
    });
  }

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark', style: TextStyle(fontSize: 28)),
        backgroundColor: AppTheme.blue,
        foregroundColor: AppTheme.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Search movie in your city...',
                ),
                onChanged: (value) {
                  print(value);
                  getMovies(query: value);
                },
              ),
              const SizedBox(
                height: 32,
              ),
              const Text(
                'TRENDING',
                style: TextStyle(color: AppTheme.white, fontSize: 16),
              ),
              const SizedBox(
                height: 16,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _movies.map((movie) => TrendingMovieCard(movie: movie)).toList(),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              const Text(
                'NOW PLAYING',
                style: TextStyle(color: AppTheme.white, fontSize: 16),
              ),
              const SizedBox(
                height: 16,
              ),
              Column(
                children: _movies.map((movie) => NowPlayingMovieCard(movie:movie)).toList(),
              )
            ],
          ),
        ),
      ),
      backgroundColor: AppTheme.grey,
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

import 'package:dio/dio.dart';
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
  List<dynamic> _searchResults = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  Future<void> getMovies({int page = 1, String? query}) async {
    final movies =
        await _movieService.getByPageAndQuery(page: page, query: query);
    setState(() {
      _movies = movies;
    });
  }

  Future<void> searchMovies() async {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      final dio = Dio();
      String url =
          'https://api.themoviedb.org/3/search/movie?include_adult=false&page=1&language=en-US';
      String nuevaUrl = '$url&query=$query';
      final String _token = const String.fromEnvironment('TOKEN');
      try {
        final Response response = await dio.get(nuevaUrl,
            options: Options(
              headers: {
                'Authorization': 'Bearer $_token',
                'accept': 'application/json'
              },
            ));
        if (response.statusCode == 200) {
          setState(() {
            _searchResults = (response.data['results'] as List)
                .map((data) => Movie.fromMap(data))
                .toList();
          });
        }
      } catch (e) {
        print(e);
        setState(() {
          _searchResults = [];
        });

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content:
                  const Text('Failed to fetch movies. Please try again later.'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context); 
                    },
                    child: const Text('OK'))
              ],
            );
          },
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void clearSearch() {
    setState(() {
      _searchResults = [];
      _searchController.clear();
      _isSearching = false; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark', style: TextStyle(fontSize: 28)),
        backgroundColor: AppTheme.blue,
        foregroundColor: AppTheme.white,
      ),
      body: GestureDetector(
        onTap: () {
          if (_searchResults.isNotEmpty) {
            setState(() {
              _searchResults.clear();
            });
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: AppTheme.grey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Search',
                                border: InputBorder.none,
                                hintTextDirection: TextDirection.ltr,
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                              style: TextStyle(color: Colors.white),
                              onSubmitted: (value) => searchMovies(),
                            ),
                          ),
                          IconButton(
                            onPressed: searchMovies,
                            icon: const Icon(Icons.search),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Lista de resultados de búsqueda
                if (_searchResults.isNotEmpty) ...[
                  Container(
                    color: Colors.white.withOpacity(0.7),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _searchResults.length,
                      itemBuilder: (BuildContext context, int index) {
                        Movie movie = _searchResults[index];
                        return ListTile(
                          leading: Image.network(
                            'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/${movie.posterPath}',
                            width: 100,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            movie.title,
                            style: TextStyle(color: AppTheme.white),
                          ),
                          subtitle: Text(
                            '${movie.releaseDate.year}-${movie.releaseDate.month.toString().padLeft(2, '0')}-${movie.releaseDate.day.toString().padLeft(2, '0')}',
                            style: TextStyle(color: AppTheme.white),
                          ),
                          trailing: Icon(Icons.star, color: Colors.yellow),
                          onTap: () {
                            Navigator.pushNamed(context, '/movie-detail',
                                arguments: {'movie': movie});
                          },
                        );
                      },
                    ),
                  ),
                ],
                const SizedBox(height: 32),
                const Text(
                  'TRENDING',
                  style: TextStyle(
                      color: AppTheme.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _movies
                        .map((movie) => TrendingMovieCard(movie: movie))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'NOW PLAYING',
                  style: TextStyle(
                      color: AppTheme.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Column(
                  children: _movies
                      .map((movie) => NowPlayingMovieCard(movie: movie))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: AppTheme.blue,
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

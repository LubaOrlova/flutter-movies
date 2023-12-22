import 'package:flutter/material.dart';
import 'package:flutter_movies/views/home.dart';
import 'package:flutter_movies/views/movie_detail.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const Home(),
        '/movie-detail': (context) {
          final dynamic args = ModalRoute.of(context)!.settings.arguments;
          return MovieDetail(movie: args!['movie']);
          },
      },
    );
  }
}

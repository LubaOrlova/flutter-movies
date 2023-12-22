import 'package:flutter_movies/models/movie.dart';

class ApiResponse {
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  const ApiResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults
  });

  static ApiResponse fromMap(Map<String, dynamic> map) => ApiResponse(
    page: map['page'],
    results: map['results'].map((movie) => Movie.fromMap(movie)).whereType<Movie>().toList(),
    totalPages: map['total_pages'],
    totalResults: map['total_results']
  );
}
import 'package:flutter_movies/models/api_response.dart';
import 'package:flutter_movies/models/movie.dart';
import 'package:dio/dio.dart';

class MovieService {
  final String  _token = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlNTQ3MjZkZGFhMzUyMzEwMGE0MzI2NGQ4YzM5NzJiNyIsInN1YiI6IjVmZDZjYjgxNjJmMzM1MDAzZWZlMWM1ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.4eHwNPG5OCyMIYXrnBgN32GNX8KFO0SVqR4KZiKSXFU';

  Future<List<Movie>> getByPageAndQuery({int page = 1, String? query}) async {
    final dio = Dio(BaseOptions(
      headers: {
        'Authorization': 'Bearer $_token',
        'Accept': 'application/json'
      }
    ));

    final params = {
      'include_adult': false,
      'include_video': false,
      'language': 'enUS',
      'page': page,
      'sort_by': 'popularity.desc'
    };

    if (query != null) params['query'] = query.replaceAll(' ', '+');

    final res = await dio.get('https://api.themoviedb.org/3/discover/movie', queryParameters: params);

    final response = ApiResponse.fromMap(res.data);

    return response.results;
  }
}
import 'package:flutter_movies/models/api_response.dart';
import 'package:flutter_movies/models/movie.dart';
import 'package:dio/dio.dart';

class MovieService {
  final String  _token = const String.fromEnvironment('TOKEN');

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
    print(_token);
    
    final res = await dio.get('https://api.themoviedb.org/3/discover/movie', queryParameters: params);

    final response = ApiResponse.fromMap(res.data);

    return response.results;
  }
}


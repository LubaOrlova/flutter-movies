import 'package:flutter/material.dart';
import 'package:flutter_movies/constants/app_theme.dart';
import 'package:flutter_movies/models/movie.dart';

class TrendingMovieCard extends StatelessWidget {
  final Movie movie;
  const TrendingMovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 120,
        margin: EdgeInsets.only(right: 16),
        child: Column(
          children: [
            Container(
              width: 120,
              height: 180,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/${movie.posterPath}'))),
            ),
            SizedBox(height: 8), 
            Container(
              height: 40,
              child: Text(
                movie.title,
                maxLines: 2, 
                overflow: TextOverflow.ellipsis, 
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.white,
                ),  
              ),
            ),
            SizedBox(height: 4), 
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow, size: 16),
                Text(
                  movie.voteAverage.toString(),
                  style: TextStyle(fontSize: 14, color: AppTheme.white),
                ),
              ],
            ),
            Text(
              '${movie.releaseDate.year}-${movie.releaseDate.month.toString().padLeft(2, '0')}-${movie.releaseDate.day.toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 12, color: AppTheme.white),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/movie-detail', arguments: {'movie': movie});
      },
    );
  }
}

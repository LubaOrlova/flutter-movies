import 'package:flutter/material.dart';
import 'package:flutter_movies/constants/app_theme.dart';
import 'package:flutter_movies/models/movie.dart';

class NowPlayingMovieCard extends StatelessWidget {
  final Movie movie;
  const NowPlayingMovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 180,
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/${movie.posterPath}'))),
            alignment: Alignment.topRight,
            child: SizedBox(
              width: 60,
              child: Chip(
                backgroundColor: AppTheme.yellow,
                labelPadding: EdgeInsets.all(0),
                label: Row(children: [
                  Icon(
                    Icons.star,
                    color: AppTheme.white,
                    size: 12,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    movie.voteAverage.toString(),
                    style: TextStyle(color: AppTheme.white, fontSize: 14),
                  )
                ]),
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          SizedBox(
            width: 280,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 245,
                      child: Text(
                        movie.title,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white),
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.bookmark, color: AppTheme.white,)
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  '${movie.releaseDate.year}-${movie.releaseDate.month.toString().padLeft(2, '0')}-${movie.releaseDate.day.toString().padLeft(2, '0')}',
                  style: TextStyle(fontSize: 12, color: AppTheme.white),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Chip(label: Text('XXI',style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.white)), backgroundColor: AppTheme.grey,),
                    SizedBox(width: 4),
                    Chip(label: Text('CVG',style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.white)), backgroundColor: AppTheme.grey,),
                    SizedBox(width: 4),
                    Chip(label: Text('Cinemas',style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.white)), backgroundColor: AppTheme.grey,)
                  ],
                ),
              ],
            ),
          )
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, '/movie-detail', arguments: {'movie': movie});
      },
    );
  }
}

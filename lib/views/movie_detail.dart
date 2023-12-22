import 'package:flutter/material.dart';
import 'package:flutter_movies/constants/app_theme.dart';
import 'package:flutter_movies/models/movie.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;
  const MovieDetail({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.blue,
      appBar: AppBar(
        title: const Text('Movie', style: TextStyle(fontSize: 28)),
        backgroundColor: AppTheme.blue,
        foregroundColor: AppTheme.white,
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(children: [
          Row(
            children: [
              Container(
                width: 140,
                height: 190,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/${movie.posterPath}'))),
              ),
              SizedBox(
                width: 16,
              ),
              SizedBox(
                width: 260,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold,color: AppTheme.white)),
                    SizedBox(
                      height: 16,),
                    Row(
                      children: [
                        Icon(Icons.star, color: AppTheme.white),
                        Text(movie.voteAverage.toString(),style: TextStyle(fontSize: 16,color: AppTheme.white)),
                        SizedBox(
                          width: 16,
                        ),
                        Icon(Icons.people, color: AppTheme.white,),
                        Text(movie.popularity.toString(), style: TextStyle(fontSize: 16,color: AppTheme.white)),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                        '${movie.releaseDate.year}-${movie.releaseDate.month.toString().padLeft(2, '0')}-${movie.releaseDate.day.toString().padLeft(2, '0')}', style: TextStyle(fontSize: 16,color: AppTheme.white)),
                    SizedBox(
                      height: 16,),
                    Row(
                      children: [
                        Icon(Icons.play_circle_fill_outlined, color: AppTheme.white),
                        Text('Watch trailer', style: TextStyle(fontSize: 16,color: AppTheme.white)),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text('Storyline',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: AppTheme.white))),
          Text(movie.overview, style: TextStyle(fontSize: 16,color: AppTheme.white)),
        ]),
      ),
    );
  }
}

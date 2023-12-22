class Movie {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  const Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount
  });

  static Movie fromMap(Map<String, dynamic> map) => Movie(
    adult: map['adult'],
    backdropPath: map['backdrop_path'],
    genreIds: map['genre_ids'].whereType<int>().toList(),
    id: map['id'],
    originalLanguage: map['original_language'],
    originalTitle: map['original_title'],
    overview: map['overview'],
    popularity: map['popularity'],
    posterPath: map['poster_path'],
    releaseDate: DateTime.parse('${map['release_date']} 00:00:00.000'),
    title: map['title'],
    video: map['video'],
    voteAverage: map['vote_average'],
    voteCount: map['vote_count'],
  );
}
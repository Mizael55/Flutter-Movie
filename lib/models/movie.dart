class Movie {
  bool adult;
  String? backdropPath;
  int id;
  String title;
  String originalTitle;
  String overview;
  String? posterPath;
  List<int> genreIds;
  double popularity;
  String? releaseDate;
  bool video;
  double voteAverage;
  int voteCount;

  Movie({
    required this.adult,
    this.backdropPath,
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    this.posterPath,
    required this.genreIds,
    required this.popularity,
    this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  get fullPosterImg {
    if (posterPath != null) {
      return 'https://image.tmdb.org/t/p/w500$posterPath';
    } else {
      return 'https://i.stack.imgur.com/GNhxO.png';
    }
  }

  get fullBackdropPath {
    if (backdropPath != null) {
      return 'https://image.tmdb.org/t/p/w500$backdropPath';
    } else {
      return 'https://i.stack.imgur.com/GNhxO.png';
    }
  }

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        id: json["id"],
        title: json["title"] ?? '',
        originalTitle: json["original_title"] ?? '',
        overview: json["overview"],
        posterPath: json["poster_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        popularity: json["popularity"]?.toDouble(),
        releaseDate: json["release_date"],
        video: json["video"] ?? false,
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "id": id,
        "title": title,
        "original_title": originalTitle,
        "overview": overview,
        "poster_path": posterPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "popularity": popularity,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

/// 🎯 MOVIE ENTITY (Domain Layer)
/// Pure Dart business object with no external dependencies.
/// Represents a movie in the business logic layer.
class Movie {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final int voteCount;
  final String? releaseDate;
  final List<int> genreIds;
  final double? popularity;
  final bool? video;
  final bool? adult;
  final String? originalLanguage;
  final String? originalTitle;

  const Movie({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.voteAverage,
    required this.voteCount,
    this.releaseDate,
    required this.genreIds,
    this.popularity,
    this.video,
    this.adult,
    this.originalLanguage,
    this.originalTitle,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Movie && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Movie(id: $id, title: $title)';
}

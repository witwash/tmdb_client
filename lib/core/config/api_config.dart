class ApiConfig {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/';

  // Image sizes
  static const String posterSizeW500 = 'w500';
  static const String backdropSizeW780 = 'w780';
  static const String posterSizeOriginal = 'original';

  // Endpoints
  static const String popularMovies = '/movie/popular';
  static const String movieDetails = '/movie/{movie_id}';
  static const String searchMovies = '/search/movie';

  /// Build full image URL
  static String getImageUrl(String? path, {String size = posterSizeW500}) {
    if (path == null || path.isEmpty) return '';
    return '$imageBaseUrl$size$path';
  }
}

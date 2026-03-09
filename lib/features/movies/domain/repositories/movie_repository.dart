import 'package:dfunc/dfunc.dart';
import 'package:tmdb_client/core/error/failure.dart';
import 'package:tmdb_client/features/movies/domain/entities/movie.dart';

/// 🎯 MOVIE REPOSITORY (Domain Layer - Interface)
/// Contract that defines how to interact with movie data.
/// Implementation is in the data layer.
abstract class MovieRepository {
  /// Fetches a list of popular movies.
  /// Returns `Either<Failure, List<Movie>>`:
  /// - Left: Failure if something goes wrong
  /// - Right: List of movies on success
  Future<Either<Failure, List<Movie>>> getPopularMovies({int page = 1});

  /// Fetches details for a specific movie.
  Future<Either<Failure, Movie>> getMovieDetails(int movieId);

  /// Searches for movies based on a query.
  Future<Either<Failure, List<Movie>>> searchMovies({
    required String query,
    int page = 1,
  });
}

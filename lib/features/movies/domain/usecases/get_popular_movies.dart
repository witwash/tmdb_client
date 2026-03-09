import 'package:dfunc/dfunc.dart';
import 'package:tmdb_client/core/error/failure.dart';
import 'package:tmdb_client/features/movies/domain/entities/movie.dart';
import 'package:tmdb_client/features/movies/domain/repositories/movie_repository.dart';

/// 🎯 GET POPULAR MOVIES USE CASE (Domain Layer)
/// Business logic: Fetch popular movies from the repository.
/// Single responsibility: Only handles getting popular movies.
class GetPopularMovies {
  final MovieRepository repository;

  const GetPopularMovies(this.repository);

  /// Execute the use case.
  /// Returns `Either<Failure, List<Movie>>`
  Future<Either<Failure, List<Movie>>> call({int page = 1}) async {
    return await repository.getPopularMovies(page: page);
  }
}

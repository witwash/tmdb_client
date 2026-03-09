import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/config/api_config.dart';
import '../models/movie_model.dart';

part 'movie_api_service.g.dart';

/// 🎯 MOVIE API SERVICE (Data Layer)
/// Uses Retrofit to define TMDB API endpoints.
/// Run `flutter pub run build_runner build` to generate implementation.
@RestApi(baseUrl: ApiConfig.baseUrl)
abstract class MovieApiService {
  factory MovieApiService(Dio dio, {String baseUrl}) = _MovieApiService;

  /// Fetches a list of popular movies from TMDB
  @GET(ApiConfig.popularMovies)
  Future<MoviesResponse> getPopularMovies({
    @Query('page') int page = 1,
    @Query('language') String language = 'en-US',
  });

  /// Fetches details for a specific movie
  @GET(ApiConfig.movieDetails)
  Future<MovieModel> getMovieDetails({
    @Path('movie_id') required int movieId,
    @Query('language') String language = 'en-US',
  });

  /// Searches for movies based on a query
  @GET(ApiConfig.searchMovies)
  Future<MoviesResponse> searchMovies({
    @Query('query') required String query,
    @Query('page') int page = 1,
    @Query('language') String language = 'en-US',
    @Query('include_adult') bool includeAdult = false,
  });
}

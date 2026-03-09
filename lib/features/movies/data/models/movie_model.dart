import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

/// 🎯 MOVIE MODEL (Data Layer)
/// Handles JSON serialization from TMDB API.
@freezed
abstract class MovieModel with _$MovieModel {
  const factory MovieModel({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'overview') required String overview,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'vote_average') required double voteAverage,
    @JsonKey(name: 'vote_count') required int voteCount,
    @JsonKey(name: 'release_date') String? releaseDate,
    @JsonKey(name: 'genre_ids') required List<int> genreIds,
    @JsonKey(name: 'popularity') double? popularity,
    @JsonKey(name: 'video') bool? video,
    @JsonKey(name: 'adult') bool? adult,
    @JsonKey(name: 'original_language') String? originalLanguage,
    @JsonKey(name: 'original_title') String? originalTitle,
  }) = _MovieModel;

  /// Factory for JSON deserialization
  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);
}

/// 🎯 MOVIES RESPONSE MODEL
/// Wrapper for TMDB paginated responses
@freezed
abstract class MoviesResponse with _$MoviesResponse {
  const factory MoviesResponse({
    @JsonKey(name: 'page') required int page,
    @JsonKey(name: 'results') required List<MovieModel> results,
    @JsonKey(name: 'total_pages') required int totalPages,
    @JsonKey(name: 'total_results') required int totalResults,
  }) = _MoviesResponse;

  /// Factory for JSON deserialization
  factory MoviesResponse.fromJson(Map<String, dynamic> json) =>
      _$MoviesResponseFromJson(json);
}

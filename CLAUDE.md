# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Flutter application for practicing REST API integration with The Movie Database (TMDB) API, following **Clean Architecture** principles with **Signals** for reactive state management.

## Essential Commands

### Code Generation (Retrofit + Freezed + JSON)
```bash
# One-time build (use after creating/modifying models or API service)
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode for development (auto-regenerates on file changes)
flutter pub run build_runner watch
```

**When to run**: After modifying `@freezed` models, Retrofit API service interfaces, or `@JsonSerializable` classes.

### Testing
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/path/to/test_file.dart

# Run with coverage
flutter test --coverage
```

### Linting
```bash
# Analyze code (includes DCM rules)
flutter analyze

# Format code
flutter format .
```

### Development
```bash
# Install dependencies
flutter pub get

# Run app
flutter run
```

## Architecture: Clean Architecture with 3 Layers

This project strictly follows Clean Architecture with clear dependency rules:

```
Presentation Layer  (UI, Screens, Widgets, Signals)
       ↓ depends on
Domain Layer       (Entities, Use Cases, Repository Interfaces)
       ↑ implemented by
Data Layer         (Models, API Service, Repository Implementations)
```

### Critical Dependency Rules

1. **Domain layer has ZERO external dependencies**
   - Pure Dart only, no Flutter imports
   - No dio, freezed, signals, or any external packages
   - Contains: entities (pure Dart classes), use cases, repository interfaces

2. **Presentation depends ONLY on Domain**
   - Import domain entities and use cases only
   - Never import from data layer directly
   - Use Signals for reactive state management

3. **Data implements Domain interfaces**
   - Repository implementations must be in data layer
   - Models extend or map to domain entities
   - Exceptions thrown in data sources, caught and converted to Failures in repositories

### Layer Structure

```
lib/features/[feature]/
├── domain/
│   ├── entities/          # Pure Dart business objects
│   ├── repositories/      # Abstract repository interfaces
│   └── usecases/          # One use case = one business action
│
├── data/
│   ├── models/            # Freezed models with JSON (extend entities)
│   ├── datasources/       # API service (Retrofit) & data source implementations
│   └── repositories/      # Implements domain repository interfaces
│
└── presentation/
    ├── signals/           # Signals-based state management
    ├── screens/           # Full-page widgets
    └── widgets/           # Reusable UI components
```

## Error Handling Pattern

This project uses **dfunc's Either** type for functional error handling:

```dart
// Return type from repositories and use cases
Future<Either<Failure, List<Movie>>> getPopularMovies();

// Handle with fold
result.fold(
  left: (failure) => handleError(failure.message),
  right: (movies) => displayMovies(movies),
);
```

**Key principle**: Data layer throws exceptions (ServerException, NetworkException), repositories catch them and return `Either<Failure, Success>`.

## State Management: Signals

Using **signals** and **signals_flutter** packages for reactive state:

```dart
// Create signal
final movies = signal<List<Movie>>([]);

// Update signal
movies.value = newMovies;

// Observe in widgets
Watch((context) => Text('Count: ${movies.value.length}'))
```

## Code Generation Workflow

### Freezed Models (Data Layer)
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@freezed
class MovieModel with _$MovieModel {
  const factory MovieModel({
    required int id,
    required String title,
    @JsonKey(name: 'poster_path') String? posterPath,
  }) = _MovieModel;

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);
}
```

After creating/modifying, run: `flutter pub run build_runner build --delete-conflicting-outputs`

### Retrofit API Service (Data Layer)
```dart
import 'package:retrofit/retrofit.dart';

part 'movie_api_service.g.dart';

@RestApi(baseUrl: ApiConfig.baseUrl)
abstract class MovieApiService {
  factory MovieApiService(Dio dio, {String baseUrl}) = _MovieApiService;

  @GET('/movie/popular')
  Future<MoviesResponse> getPopularMovies({
    @Query('page') int page = 1,
  });
}
```

After creating/modifying, run: `flutter pub run build_runner build --delete-conflicting-outputs`

## Environment Configuration

### .env File (Required)
Create `.env` in project root:
```env
TMDB_API_KEY=your_api_key_here
```

The app loads this via `flutter_dotenv` in `main.dart`. Never commit `.env` to git.

### Getting TMDB API Key
1. Create account at https://www.themoviedb.org/
2. Settings → API → Request API key (free)

## Key Technical Details

### Retrofit + Dio Setup
- **Retrofit**: Type-safe REST client generator (eliminates boilerplate)
- **Dio Interceptors**:
  - `ApiKeyInterceptor` automatically adds TMDB API key to query params
  - `LogInterceptor` for debugging HTTP requests
- **Base URL**: https://api.themoviedb.org/3
- **Image URLs**: https://image.tmdb.org/t/p/{size}{path}

### Dependency Injection
- Uses **GetIt** service locator pattern
- Setup in `core/injection/injection_container.dart`
- Lazy singletons for repositories
- Factories for state objects

### Linting
- **flutter_lints** ^6.0.0: Flutter recommended rules
- **DCM** (Dart Code Metrics): Configured in `analysis_options.yaml` with recommended rules

## Common Violations to Avoid

❌ **DON'T import Flutter in domain layer**
```dart
// Wrong: domain/entities/movie.dart
import 'package:flutter/material.dart'; // ❌ Never!
```

❌ **DON'T import data layer in presentation**
```dart
// Wrong: presentation/signals/movies_state.dart
import '../../data/datasources/movie_api_service.dart'; // ❌ Use use cases instead
```

❌ **DON'T return models to presentation**
```dart
// Wrong: data/repositories/movie_repository_impl.dart
Future<Either<Failure, List<MovieModel>>> getMovies() // ❌ Return entities!
```

❌ **DON'T put multiple actions in one use case**
```dart
// Wrong: Single use case doing many things
class MovieOperations {
  getAllMoviesAndDetailsAndSearch() // ❌ Split into separate use cases
}
```

✅ **DO follow single responsibility**: One use case per action (GetPopularMovies, SearchMovies, GetMovieDetails, etc.)

## Data Flow Example

```
UI Screen
  ↓ calls
MoviesState (Signals)
  ↓ calls
GetPopularMovies UseCase
  ↓ calls
MovieRepository Interface (domain)
  ↓ implemented by
MovieRepositoryImpl (data)
  ↓ calls
MovieRemoteDataSource
  ↓ calls
MovieApiService (Retrofit)
  ↓ HTTP GET
TMDB API
```

## Current Project Status

- ✅ Clean Architecture structure defined
- ✅ Retrofit integrated with Dio
- ✅ Freezed models setup
- ✅ API configuration and interceptors
- 🚧 Dependency injection (GetIt) - not yet wired
- 🚧 Use cases and repositories - not yet implemented
- 🚧 Signals state management - not yet implemented in UI
- 🚧 Full presentation layer - placeholder UI only

## Documentation References

- Complete tech stack details: `docs/TECH_STACK.md`
- Architecture diagrams and patterns: See TECH_STACK.md sections on layers, data flow, and testing
- TMDB API reference: https://developer.themoviedb.org/docs
- Clean Architecture principles: Referenced throughout TECH_STACK.md

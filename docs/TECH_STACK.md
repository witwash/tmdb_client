# 🚀 TMDB Client - Tech Stack & Architecture

## 📋 Project Overview

A Flutter application for practicing REST API skills with The Movie Database (TMDB) API, following **Clean Architecture** principles with **Signals** for state management.

**Project Goal**: Build a production-quality movie browsing app while mastering REST API integration, Clean Architecture patterns, and modern Flutter development practices.

---

## 🎯 Learning Objectives

- ✅ REST API integration with proper error handling
- ✅ Clean Architecture implementation in Flutter
- ✅ Signals-based reactive state management
- ✅ Functional programming with Either pattern
- ✅ Code generation with Freezed and JSON serialization
- ✅ Dependency injection patterns
- ✅ Separation of concerns across layers

---

## 🏗️ Architecture

### Clean Architecture Layers

```
┌─────────────────────────────────────────────────────────────┐
│                   PRESENTATION LAYER                        │
│         (UI, Screens, Widgets, Signals State)              │
│                                                             │
│  Dependencies: Domain only                                  │
│  Responsibilities:                                          │
│  • Display data to users                                    │
│  • Handle user interactions                                 │
│  • Manage UI state with Signals                            │
│  • Format data for display                                  │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│                     DOMAIN LAYER                            │
│      (Entities, Use Cases, Repository Interfaces)          │
│                                                             │
│  Dependencies: NONE (Pure Dart)                            │
│  Responsibilities:                                          │
│  • Define business entities                                 │
│  • Define business rules (use cases)                        │
│  • Define repository contracts (interfaces)                 │
│  • Independent of frameworks and external libraries         │
└────────────────────────┬────────────────────────────────────┘
                         ▲
                         │
┌────────────────────────┴────────────────────────────────────┐
│                     DATA LAYER                              │
│        (Models, Data Sources, Repository Impl)             │
│                                                             │
│  Dependencies: Domain only                                  │
│  Responsibilities:                                          │
│  • Implement repository interfaces                          │
│  • Fetch data from remote/local sources                     │
│  • Convert models to entities                               │
│  • Handle data exceptions                                   │
└─────────────────────────────────────────────────────────────┘
```

### Core Architectural Principles

#### ✅ Dependency Rule
**Dependencies point inward only**
- Presentation → Domain ← Data
- Inner layers never depend on outer layers
- Domain layer has ZERO dependencies

#### ✅ Single Responsibility Principle (SRP)
- Each class/module has one reason to change
- Use cases do one thing only
- Separate concerns across layers

#### ✅ Dependency Inversion Principle (DIP)
- Depend on abstractions, not concretions
- Repository interfaces in domain, implementations in data
- Presentation depends on use case abstractions

#### ✅ Interface Segregation Principle (ISP)
- Small, focused interfaces
- Abstract data sources for testability
- No fat interfaces

#### ✅ Open/Closed Principle (OCP)
- Open for extension, closed for modification
- Add new features without changing existing code
- Use composition over inheritance

---

## 📦 Tech Stack

### State Management
| Package | Version | Purpose |
|---------|---------|---------|
| **`signals`** | ^5.5.0 | Core signals implementation for reactive state |
| **`signals_flutter`** | ^5.5.0 | Flutter widgets integration (Watch, etc.) |

**Why Signals?**
- Lightweight and performant
- Fine-grained reactivity
- Less boilerplate than BLoC
- Excellent for learning reactive patterns
- No BuildContext needed for state updates

---

### HTTP & Networking
| Package | Version | Purpose |
|---------|---------|---------|
| **`dio`** | ^5.7.0 | HTTP client for REST API calls |
| **`retrofit`** | ^4.1.0 | Type-safe REST client generator |

**Why Dio & Retrofit?**
- **Type Safety**: Retrofit generates type-safe API clients from simple interfaces.
- **Interceptors**: `ApiKeyInterceptor` automatically adds the TMDB API key to every request.
- **Ease of Use**: Reduces boilerplate by handling JSON mapping and endpoint configuration.
- **Logging**: Pre-configured `LogInterceptor` for development debugging.
- **Timeout Support**: Standardized connection and receive timeouts.

---

### Functional Programming
| Package | Version | Purpose |
|---------|---------|---------|
| **`dfunc`** | ^0.10.0 | Lightweight functional utilities for Dart |

**Why dfunc?**
- **Dart-Native**: More aligned with Dart's philosophy than heavier FP libraries.
- **Either Type**: Provides clean error handling without throwing exceptions.
- **Optional Extensions**: Kotlin-like `let` and `maybeMap` for safe nullable handling.
- **Lightweight**: Minimal impact on binary size while providing essential FP tools.

---

### Code Generation
| Package | Version | Purpose |
|---------|---------|---------|
| **`freezed`** | ^2.5.7 | Immutable data classes with code generation |
| **`freezed_annotation`** | ^2.4.4 | Annotations for Freezed |
| **`json_serializable`** | ^6.8.0 | JSON serialization code generation |
| **`json_annotation`** | ^4.9.0 | Annotations for JSON serialization |
| **`build_runner`** | ^2.4.13 | Runs code generators |

**Why Freezed?**
- Generates `copyWith`, `==`, `hashCode`, `toString`
- Union types and sealed classes support
- Immutability by default
- Reduces boilerplate significantly

---

### Dependency Injection
| Package | Version | Purpose |
|---------|---------|---------|
| **`get_it`** | ^8.0.2 | Service locator for dependency injection |

**Why GetIt?**
- Simple and lightweight
- Lazy singletons for repositories
- Factories for state objects
- No code generation required
- Works well with Clean Architecture

---

### Environment & Configuration
| Package | Version | Purpose |
|---------|---------|---------|
| **`flutter_dotenv`** | ^5.2.1 | Environment variable management |

**Why flutter_dotenv?**
- Keep API keys out of source control
- Different configurations for dev/staging/prod
- Security best practice

---

### UI & Assets
| Package | Version | Purpose |
|---------|---------|---------|
| **`cached_network_image`** | ^3.4.1 | Image caching for network images |
| **`go_router`** | ^14.6.2 | Declarative routing and navigation |

**Why these?**
- `cached_network_image`: Automatic caching, placeholder support, memory efficient
- `go_router`: Type-safe navigation, deep linking, works great with any state management

---

### Development Tools
| Package | Version | Purpose |
|---------|---------|---------|
| **`flutter_lints`** | ^6.0.0 | Recommended linting rules |

---

## 📂 Project Structure

```
lib/
├── main.dart                              # App entry point
├── app.dart                               # Root widget & router setup
│
├── core/                                  # Shared utilities & infrastructure
│   ├── config/
│   │   └── api_config.dart               # API endpoints, base URLs, constants
│   ├── error/
│   │   ├── failures.dart                 # Domain-level failure classes
│   │   └── exceptions.dart               # Data-level exception classes
│   ├── network/
│   │   ├── api_key_interceptor.dart      # Adds API key to query params
│   │   └── dio_client.dart               # Dio initialization & setup
│   └── injection/
│       └── injection_container.dart      # GetIt dependency injection setup
│
└── features/                              # Feature-based modules
    └── movies/                            # Movies feature
        │
        ├── domain/                        # 🟢 DOMAIN LAYER (Pure Dart)
        │   ├── entities/
        │   │   └── movie.dart            # Business entity (immutable, pure Dart)
        │   ├── repositories/
        │   │   └── movie_repository.dart # Repository interface (contract)
        │   └── usecases/
        │       ├── get_popular_movies.dart     # Use case: Fetch popular movies
        │       ├── get_movie_details.dart      # Use case: Fetch movie details
        │       └── search_movies.dart          # Use case: Search movies
        │
        ├── data/                          # 🔵 DATA LAYER (Implementation)
        │   ├── models/
        │   │   └── movie_model.dart      # Freezed model + JSON (extends entity)
        │   ├── datasources/
        │   │   ├── movie_api_service.dart             # Retrofit API interface
        │   │   ├── movie_remote_datasource.dart       # Data source interface
        │   │   └── movie_remote_datasource_impl.dart  # Impl using MovieApiService
        │   └── repositories/
        │       └── movie_repository_impl.dart  # Repository implementation
        │
        └── presentation/                  # 🟡 PRESENTATION LAYER (UI)
            ├── signals/
            │   └── movies_state.dart     # Signals-based state management
            ├── screens/
            │   ├── movies_list_screen.dart       # Popular movies screen
            │   └── movie_detail_screen.dart      # Movie details screen
            └── widgets/
                └── movie_card.dart        # Reusable movie card widget
```

### Layer Responsibilities

#### 🟢 Domain Layer
**Location**: `features/[feature]/domain/`
- **Entities**: Business objects (pure Dart classes)
- **Repositories**: Interfaces/contracts only (abstract classes)
- **Use Cases**: Business logic, one action per use case
- **Rules**: 
  - ✅ Pure Dart only
  - ✅ No Flutter dependencies
  - ✅ No external packages (except Dart SDK)
  - ✅ No knowledge of data sources or UI

#### 🔵 Data Layer
**Location**: `features/[feature]/data/`
- **Models**: Freezed classes with JSON serialization
- **Data Sources**: Remote (API) and Local (Database/Cache) implementations
- **Repositories**: Implement domain repository interfaces
- **Rules**:
  - ✅ Implements domain interfaces
  - ✅ Converts models to entities
  - ✅ Handles exceptions, returns Either
  - ✅ No direct UI dependencies

#### 🟡 Presentation Layer
**Location**: `features/[feature]/presentation/`
- **Signals State**: Manages UI state reactively
- **Screens**: Full-page widgets
- **Widgets**: Reusable UI components
- **Rules**:
  - ✅ Depends on domain (use cases, entities)
  - ✅ No data layer imports
  - ✅ No business logic
  - ✅ UI formatting only

---

## 🔄 Data Flow

### Example: Fetching Popular Movies

```
┌─────────────────────────────────────────────────────────────┐
│ 1. UI Layer (MoviesListScreen)                             │
│    User opens screen                                        │
│    └─> Calls: moviesState.loadPopularMovies()             │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│ 2. Presentation Layer (MoviesState)                        │
│    State management with Signals                            │
│    └─> Calls: getPopularMovies() use case                 │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│ 3. Domain Layer (GetPopularMovies)                         │
│    Business logic / Use case                                │
│    └─> Calls: repository.getPopularMovies()               │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│ 4. Data Layer (MovieRepositoryImpl)                        │
│    Repository implementation                                │
│    └─> Calls: remoteDataSource.getPopularMovies()         │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│ 5. Data Layer (MovieRemoteDataSourceImpl)                  │
│    Calls MovieApiService (Retrofit)                         │
│    GET /movie/popular                                       │
│    (ApiKeyInterceptor adds api_key=xxx)                    │
│    ├─ Success: Returns MoviesResponse                     │
│    └─ Error: Throws ServerException/NetworkException      │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│ 6. Data Layer (MovieRepositoryImpl)                        │
│    Handles response                                         │
│    ├─ Catch exceptions → Convert to Failures              │
│    ├─ Convert MovieModel → Movie entity                   │
│    └─ Return Either<Failure, List<Movie>>                 │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│ 7. Domain Layer (GetPopularMovies)                         │
│    Passes Either to presentation                            │
│    └─> Returns Either<Failure, List<Movie>>               │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│ 8. Presentation Layer (MoviesState)                        │
│    Updates signals based on Either result                   │
│    result.fold(                                            │
│      (failure) => errorMessage.value = failure.message,    │
│      (movies) => movies.value = movies,                    │
│    )                                                       │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│ 9. UI Layer (MoviesListScreen)                             │
│    Watch() widget rebuilds on signal changes                │
│    ├─ Error: Display error message with retry button      │
│    └─ Success: Display grid of movie cards                │
└─────────────────────────────────────────────────────────────┘
```

---

## 🎯 Clean Architecture Rules

### ✅ DO

#### Domain Layer
- ✅ Use **pure Dart classes** for entities (no Flutter imports)
- ✅ Create **one use case per action** (single responsibility)
- ✅ Define **repository interfaces** (abstract classes)
- ✅ Keep domain **completely independent** of frameworks
- ✅ Return **Either<Failure, Success>** from use cases (via repository)

#### Data Layer
- ✅ **Implement domain repository interfaces** in data layer
- ✅ Create **data models that extend domain entities**
- ✅ **Throw exceptions** in data sources (ServerException, NetworkException)
- ✅ **Catch exceptions in repositories** and convert to Failures
- ✅ **Convert models to entities** at the repository boundary
- ✅ Use **Freezed for models** with JSON serialization

#### Presentation Layer
- ✅ **Depend only on domain layer** (use cases, entities)
- ✅ Use **Signals for state management**
- ✅ **Handle Either results** with fold()
- ✅ Keep **UI logic separate** from business logic
- ✅ Inject dependencies via **constructor**

---

### ❌ DON'T

#### Domain Layer
- ❌ DON'T import Flutter packages in domain
- ❌ DON'T import external packages (dio, freezed, etc.)
- ❌ DON'T put multiple responsibilities in one use case
- ❌ DON'T implement repositories in domain (only interfaces)
- ❌ DON'T throw exceptions from use cases to presentation

#### Data Layer
- ❌ DON'T import presentation layer in data
- ❌ DON'T put business logic in repositories
- ❌ DON'T return models to presentation (convert to entities)
- ❌ DON'T let exceptions bubble to presentation
- ❌ DON'T access UI from data layer

#### Presentation Layer
- ❌ DON'T import data layer directly
- ❌ DON'T access data sources from UI
- ❌ DON'T put business logic in widgets or state
- ❌ DON'T bypass use cases to call repositories
- ❌ DON'T handle raw exceptions (use Either)

---

## 🚨 Common Violations & Solutions

### ❌ Violation 1: Domain importing Flutter
```dart
// ❌ WRONG - Domain importing Flutter
import 'package:flutter/material.dart';

class Movie {
  final Color primaryColor; // Flutter dependency!
}
```

```dart
// ✅ CORRECT - Pure Dart
class Movie {
  final int id;
  final String title;
  // Only Dart types
}
```

---

### ❌ Violation 2: Presentation accessing Data
```dart
// ❌ WRONG - Presentation importing data layer
import '../../data/datasources/movie_remote_datasource.dart';

class MoviesState {
  final MovieRemoteDataSource dataSource; // Direct data access!
}
```

```dart
// ✅ CORRECT - Presentation using domain use case
import '../../domain/usecases/get_popular_movies.dart';

class MoviesState {
  final GetPopularMovies getPopularMovies; // Depends on abstraction
}
```

---

### ❌ Violation 3: Repository returning models
```dart
// ❌ WRONG - Returning data models to domain
Future<Either<Failure, List<MovieModel>>> getPopularMovies() async {
  final models = await dataSource.getPopularMovies();
  return Right(models); // Leaking data models!
}
```

```dart
// ✅ CORRECT - Converting to entities
Future<Either<Failure, List<Movie>>> getPopularMovies() async {
  final models = await dataSource.getPopularMovies();
  final entities = models.map((model) => model.toEntity()).toList();
  return Right(entities); // Returning domain entities
}
```

---

### ❌ Violation 4: Use case with multiple responsibilities
```dart
// ❌ WRONG - Use case doing too much
class MovieOperations {
  Future<void> getAllMovieOperations() async {
    await getPopular();
    await searchMovies();
    await getDetails();
    await rateMovie();
  }
}
```

```dart
// ✅ CORRECT - Single responsibility per use case
class GetPopularMovies {
  Future<Either<Failure, List<Movie>>> call() async { ... }
}

class SearchMovies {
  Future<Either<Failure, List<Movie>>> call(String query) async { ... }
}

class GetMovieDetails {
  Future<Either<Failure, Movie>> call(int id) async { ... }
}
```

---

## 🧪 Testing Strategy

### Unit Tests

#### Domain Layer Tests
```dart
// Test entities (pure Dart)
test('Movie entity should be created with correct values', () {
  final movie = Movie(id: 1, title: 'Test');
  expect(movie.id, 1);
});

// Test use cases with mock repositories
test('GetPopularMovies should return movies on success', () async {
  final mockRepo = MockMovieRepository();
  final useCase = GetPopularMovies(mockRepo);
  
  when(mockRepo.getPopularMovies()).thenAnswer(
    (_) async => Right([Movie(...)]),
  );
  
  final result = await useCase();
  expect(result.isRight(), true);
});
```

#### Data Layer Tests
```dart
// Test repositories
test('Repository should convert exceptions to failures', () async {
  final mockDataSource = MockMovieRemoteDataSource();
  final repo = MovieRepositoryImpl(remoteDataSource: mockDataSource);
  
  when(mockDataSource.getPopularMovies()).thenThrow(ServerException('Error'));
  
  final result = await repo.getPopularMovies();
  expect(result.isLeft(), true);
  expect(result.fold((l) => l, (r) => null), isA<ServerFailure>());
});
```

#### Presentation Layer Tests
```dart
// Test state logic
test('MoviesState should update signals on successful fetch', () async {
  final mockUseCase = MockGetPopularMovies();
  final state = MoviesState(getPopularMovies: mockUseCase);
  
  when(mockUseCase()).thenAnswer((_) async => Right([Movie(...)]));
  
  await state.loadPopularMovies();
  
  expect(state.movies.value.length, greaterThan(0));
  expect(state.isLoading.value, false);
});
```

### Widget Tests
```dart
testWidgets('MovieCard displays movie title', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: MovieCard(movie: Movie(id: 1, title: 'Test Movie')),
    ),
  );
  
  expect(find.text('Test Movie'), findsOneWidget);
});
```

### Integration Tests
- Test complete flows (API → UI)
- Use mock API server (mockito, http_mock_adapter)
- Test navigation flows
- Test error scenarios

---

## 🔐 Environment Setup

### `.env` File Structure
```bash
# TMDB API Configuration
TMDB_API_KEY=your_api_key_here

# Optional: Different environments
TMDB_BASE_URL=https://api.themoviedb.org/3
IMAGE_BASE_URL=https://image.tmdb.org/t/p/
```

### Getting TMDB API Key
1. Create account at [TMDB](https://www.themoviedb.org/)
2. Go to Settings → API
3. Request API key (free)
4. Copy key to `.env` file

### Security Best Practices
- ✅ Add `.env` to `.gitignore`
- ✅ Never commit API keys
- ✅ Use environment-specific configs
- ✅ Document required env vars in README

---

## 🚀 Code Generation Commands

### Run Once
```bash
flutter pub run build_runner build
```

### Watch for Changes (Development)
```bash
flutter pub run build_runner watch
```

### Clean and Rebuild
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### When to Run
- ✅ After creating/modifying Freezed models
- ✅ After changing JSON serialization
- ✅ When you see "part of" file errors
- ✅ After pulling code from git

---

## 📚 Key Concepts

### Signals Pattern

#### Creating Signals
```dart
// Mutable reactive state
final counter = signal<int>(0);
final name = signal<String>('John');
final movies = signal<List<Movie>>([]);

// Update signals
counter.value = 5;
movies.value = [...movies.value, newMovie];
```

#### Computed Signals (Derived State)
```dart
final counter = signal(5);
final doubled = computed(() => counter.value * 2);

print(doubled.value); // 10
counter.value = 10;
print(doubled.value); // 20 (automatically updated)
```

#### Effects (Side Effects)
```dart
effect(() {
  print('Counter changed: ${counter.value}');
}); // Runs whenever counter changes
```

#### Signals in Widgets
```dart
class MyWidget extends StatelessWidget {
  final Signal<int> counter;
  
  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      // Rebuilds only when counter changes
      return Text('Count: ${counter.value}');
    });
  }
}
```

---

### Either Pattern (Error Handling)

#### Creating Either
```dart
import 'package:dfunc/dfunc.dart';

// Success
return Either.right(movie);

// Failure
return Either.left(ServerFailure('Error'));
```

#### Handling Either with Fold
```dart
final result = await repository.getMovie(1);

result.fold(
  left: (failure) {
    // Handle error (Left side)
    print('Error: ${failure.message}');
  },
  right: (movie) {
    // Handle success (Right side)
    print('Success: ${movie.title}');
  },
);
```

---

### Freezed Models

#### Basic Freezed Class
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

#### Generated Features
```dart
// Equality
movie1 == movie2; // Compares all fields

// Copy with
final updated = movie.copyWith(title: 'New Title');

// toString
print(movie); // MovieModel(id: 1, title: "Test", ...)

// Immutability
movie.title = 'New'; // ❌ Compile error!
```

---

### Dependency Injection with GetIt

#### Setup
```dart
final getIt = GetIt.instance;

void setupDependencies() {
  // Singleton (created once, lives forever)
  getIt.registerLazySingleton<Dio>(() => Dio());
  
  // Factory (created every time you request it)
  getIt.registerFactory<MoviesState>(() => MoviesState(...));
  
  // Async registration
  getIt.registerSingletonAsync<Database>(() async {
    return await openDatabase();
  });
}
```

#### Usage
```dart
// Get dependency
final dio = getIt<Dio>();
final state = getIt<MoviesState>();

// In widgets
class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesState = getIt<MoviesState>();
    return MoviesListScreen(moviesState: moviesState);
  }
}
```

---

## 📖 TMDB API Reference

### Base URL
```
https://api.themoviedb.org/3
```

### Common Endpoints

#### Get Popular Movies
```
GET /movie/popular?api_key={key}&page={page}
```

#### Get Movie Details
```
GET /movie/{movie_id}?api_key={key}
```

#### Search Movies
```
GET /search/movie?api_key={key}&query={query}
```

#### Image URLs
```
https://image.tmdb.org/t/p/{size}{path}

Sizes: w92, w154, w185, w342, w500, w780, original
```

### Response Structure
```json
{
  "page": 1,
  "results": [
    {
      "id": 123,
      "title": "Movie Title",
      "overview": "Plot summary...",
      "poster_path": "/abc123.jpg",
      "backdrop_path": "/xyz789.jpg",
      "vote_average": 7.5,
      "vote_count": 1000,
      "release_date": "2024-01-01",
      "genre_ids": [28, 12, 878]
    }
  ],
  "total_pages": 500,
  "total_results": 10000
}
```

---

## 🎓 Learning Resources

### Clean Architecture
- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Clean Architecture by Reso Coder](https://resocoder.com/flutter-clean-architecture-tdd/)
- [SOLID Principles](https://www.digitalocean.com/community/conceptual_articles/s-o-l-i-d-the-first-five-principles-of-object-oriented-design)

### Flutter & Dart
- [Flutter Documentation](https://flutter.dev/docs)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [Flutter Signals Documentation](https://dartsignals.dev/)

### Packages
- [Freezed Package Guide](https://pub.dev/packages/freezed)
- [dfunc Documentation](https://pub.dev/packages/dfunc)
- [Dio Documentation](https://pub.dev/packages/dio)
- [GetIt Documentation](https://pub.dev/packages/get_it)

### API Integration
- [TMDB API Documentation](https://developer.themoviedb.org/docs)
- [REST API Best Practices](https://restfulapi.net/)

---

## 🗺️ Development Roadmap

### Phase 1: Foundation ✅
- [x] Project setup
- [x] Tech stack selection
- [x] Architecture documentation
- [ ] Dependency injection setup
- [ ] API configuration

### Phase 2: Core Features
- [ ] Popular movies list
- [ ] Movie details screen
- [ ] Search functionality
- [ ] Error handling
- [ ] Loading states

### Phase 3: Polish
- [ ] Pagination
- [ ] Pull-to-refresh
- [ ] Image caching optimization
- [ ] Empty states
- [ ] Offline support (optional)

### Phase 4: Advanced
- [ ] Movie categories (Top Rated, Upcoming)
- [ ] Favorites (local storage)
- [ ] User reviews
- [ ] Video trailers
- [ ] Share functionality

---

## 📝 Development Guidelines

### Before Starting a Feature
1. ✅ Design the domain entity first
2. ✅ Define the use case(s)
3. ✅ Create repository interface in domain
4. ✅ Implement data layer (model, data source, repository)
5. ✅ Build presentation layer (signals state, UI)
6. ✅ Wire up dependency injection

### Code Review Checklist
- [ ] Domain has no external dependencies
- [ ] Data implements domain interfaces
- [ ] Presentation depends only on domain
- [ ] Exceptions converted to Failures
- [ ] Models converted to Entities
- [ ] Single responsibility maintained
- [ ] Proper error handling with Either
- [ ] Signals used for UI state
- [ ] No business logic in UI

### Git Commit Convention
```
feat: Add popular movies feature
fix: Handle null poster paths
refactor: Extract movie card widget
docs: Update architecture documentation
test: Add unit tests for GetPopularMovies
```

---

## 🐛 Troubleshooting

### "Part of" errors
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### API returns 401 Unauthorized
- Check `.env` file exists
- Verify TMDB_API_KEY is correct
- Ensure `.env` is in assets in `pubspec.yaml`

### Signals not updating UI
- Ensure you're using `Watch` widget
- Check signal.value is being set correctly
- Verify context is from Watch builder

### Dependency injection errors
- Ensure `setupDependencies()` is called in main()
- Check registration order (dependencies first)
- Verify correct types in getIt<Type>()

---

## 📊 Project Metrics

### Code Organization
- **Feature Isolation**: Each feature is self-contained
- **Layer Separation**: Clear boundaries between layers
- **Testability**: >80% code coverage goal
- **Maintainability**: SOLID principles throughout

### Performance Targets
- Initial load: < 2 seconds
- Image caching: 95% hit rate
- Memory usage: < 100MB average
- Smooth scrolling: 60 FPS

---

## 🤝 Contributing Guidelines

This is a learning project, but follow these principles:

1. **Respect Clean Architecture** - No violations
2. **Write Tests** - Unit tests for domain and data
3. **Document Decisions** - Update this file when needed
4. **Keep It Simple** - Don't over-engineer
5. **Learn and Iterate** - It's okay to refactor

---

## 📄 License

This is a learning project. Feel free to use it as a reference.

---

## 📞 Support

For questions about:
- **Clean Architecture**: Reference this document or Uncle Bob's blog
- **Signals**: Check [dartsignals.dev](https://dartsignals.dev/)
- **TMDB API**: See [TMDB API Docs](https://developer.themoviedb.org/docs)

---

**Last Updated**: 2026
**Flutter SDK**: ^3.10.9  
**Dart SDK**: ^3.10.9  
**Architecture**: Clean Architecture  
**State Management**: Signals  

---

*This document is a living guide. Update it as the project evolves and new patterns emerge.*
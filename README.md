# 🎬 TMDB Client

A Flutter playground for practicing REST API integration with The Movie Database (TMDB) API.

## 🎯 Purpose

This project is designed for learning and practicing:
- **REST API integration** with Flutter and Dio
- **Clean Architecture** principles and layer separation
- **Signals** state management for reactive UI
- **Functional error handling** with Either pattern
- **Code generation** with Freezed and JSON serialization
- **Dependency injection** patterns with GetIt

## 📚 Documentation

**📖 [Complete Tech Stack & Architecture Guide](docs/TECH_STACK.md)**

This comprehensive guide includes:
- Architecture overview with visual diagrams
- Complete package list with version and rationale
- Detailed project structure
- Layer responsibilities and rules
- Data flow examples
- Clean Architecture DO's and DON'Ts
- Common violations and solutions
- Testing strategy
- Code examples and patterns
- TMDB API reference
- Development roadmap

## 🚀 Quick Start

### Prerequisites
- Flutter SDK ^3.10.9
- Dart SDK ^3.10.9
- TMDB API account

### Setup Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd tmdb_client
   ```

2. **Get TMDB API Key**
   - Create account at [TMDB](https://www.themoviedb.org/)
   - Go to Settings → API
   - Request API key (free)

3. **Configure environment**
   
   Create `.env` file in project root:
   ```env
   TMDB_API_KEY=your_api_key_here
   ```

4. **Install dependencies**
   ```bash
   flutter pub get
   ```

5. **Run code generation**
   ```bash
   flutter pub run build_runner build
   ```

6. **Run the app**
   ```bash
   flutter run
   ```

## 🏗️ Architecture Overview

This project follows **Clean Architecture** with three distinct layers:

```
┌─────────────────────────┐
│   PRESENTATION LAYER    │  ← UI, Screens, Widgets, Signals State
│   (Depends on Domain)   │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│     DOMAIN LAYER        │  ← Entities, Use Cases, Repository Interfaces
│   (Pure Dart - No Deps) │  ← Business Logic
└───────────┬─────────────┘
            ▲
            │
┌───────────┴─────────────┐
│      DATA LAYER         │  ← Models, Data Sources, Repository Impl
│   (Depends on Domain)   │  ← API Integration
└─────────────────────────┘
```

**Key Principle**: Dependencies point inward. The Domain layer has zero dependencies.

## 🛠️ Tech Stack Summary

| Category | Package | Purpose |
|----------|---------|---------|
| **State Management** | signals, signals_flutter | Reactive state management |
| **HTTP Client** | dio | REST API requests |
| **Error Handling** | fpdart | Either pattern for elegant error handling |
| **Code Generation** | freezed, json_serializable | Immutable models & JSON |
| **Dependency Injection** | get_it | Service locator pattern |
| **Environment Config** | flutter_dotenv | Secure API key management |
| **Image Caching** | cached_network_image | Optimized image loading |
| **Navigation** | go_router | Declarative routing |

## 📂 Project Structure

```
lib/
├── core/                    # Shared utilities
│   ├── config/             # API configuration
│   ├── error/              # Failures & exceptions
│   ├── network/            # Dio setup
│   └── injection/          # Dependency injection
│
└── features/               # Feature modules
    └── movies/
        ├── domain/         # Business logic (pure Dart)
        ├── data/           # API implementation
        └── presentation/   # UI & state management
```

## 🎓 Learning Goals

- [x] Set up Clean Architecture structure
- [x] Configure tech stack
- [ ] Implement popular movies feature
- [ ] Add movie details screen
- [ ] Implement search functionality
- [ ] Handle errors with Either pattern
- [ ] Add pagination
- [ ] Implement caching strategy

## 📖 Key Resources

- **[Tech Stack Documentation](docs/TECH_STACK.md)** - Complete reference
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) - Uncle Bob's original article
- [Flutter Signals](https://dartsignals.dev/) - Signals documentation
- [TMDB API Docs](https://developer.themoviedb.org/docs) - API reference
- [Freezed Guide](https://pub.dev/packages/freezed) - Code generation

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/features/movies/domain/usecases/get_popular_movies_test.dart
```

## 🔧 Development Commands

```bash
# Get dependencies
flutter pub get

# Run code generation (one-time)
flutter pub run build_runner build

# Watch mode (auto-regenerate on changes)
flutter pub run build_runner watch

# Clean and rebuild
flutter pub run build_runner build --delete-conflicting-outputs

# Format code
flutter format .

# Analyze code
flutter analyze
```

## 🚨 Clean Architecture Rules

This project strictly follows Clean Architecture. Key rules:

✅ **DO:**
- Keep domain layer pure (no external dependencies)
- Use Either<Failure, Success> for error handling
- Create one use case per action
- Convert models to entities at boundaries
- Inject dependencies via constructors

❌ **DON'T:**
- Import Flutter in domain layer
- Import data layer in presentation
- Throw exceptions to presentation layer
- Put business logic in UI
- Access data sources directly from UI

See [TECH_STACK.md](docs/TECH_STACK.md#-clean-architecture-rules) for complete rules and examples.

## 🐛 Troubleshooting

**Code generation errors?**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

**API not working?**
- Verify `.env` file exists in project root
- Check TMDB_API_KEY is valid
- Ensure `.env` is listed in `pubspec.yaml` assets

**Signals not updating?**
- Ensure you're using `Watch` widget
- Verify signal.value is being updated

## 📄 License

This is a learning project. Feel free to use as reference.

---

**Status**: 🚧 In Development  
**Architecture**: Clean Architecture  
**State Management**: Signals  
**Last Updated**: 2024
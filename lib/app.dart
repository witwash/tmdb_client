import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_client/features/movies/data/datasources/movie_api_service.dart';

class App extends StatefulWidget {
  const App({super.key});
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late MovieApiService _apiService;
  late Dio _dio;
  late Future<String> _result;

  @override
  void initState() {
    super.initState();
    _dio = Dio();
    _apiService = MovieApiService(_dio);
    _result = _testingFuture();
  }

  @override
  void dispose() {
    _dio.close();
    super.dispose();
  }

  Future<String> _testingFuture() async {
    final result = await _apiService.getPopularMovies();
    final topMovie = result.results.firstOrNull;
    return 'Top Movie: ${topMovie ?? "Not found :-/"}';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _result,
      builder: (context, snapshot) {
        return Center(
          child: switch (snapshot) {
            AsyncSnapshot(hasData: true, :final data) =>
              Text('Data is ${data ?? "No data"}'),
            AsyncSnapshot<String>(data: String(), hasData: false) ||
            AsyncSnapshot<String>(data: null, hasData: false) =>
              const Column(
                children: [CircularProgressIndicator(), Text('Waiting...')],
              ),
          },
        );
      },
    );
  }
}

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
    _result = _testingFuture();
    _dio = Dio();
    _apiService = MovieApiService(_dio);
  }

  Future<String> _testingFuture() async {
    final result = await _apiService.getPopularMovies();
    final topMovie = result.results.firstOrNull ?? 'Not found :-/';
    return 'Top Movie: $topMovie';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _result,
      builder: (context, snapshot) {
        return Center(
          child: switch (snapshot) {
            AsyncSnapshot(hasData: true, :final data) => Text('Data is $data'),
            AsyncSnapshot<String>(data: String(), hasData: false) ||
            AsyncSnapshot<String>(data: null, hasData: false) => Column(
              children: [CircularProgressIndicator(), Text('Waiting...')],
            ),
          },
        );
      },
    );
  }
}

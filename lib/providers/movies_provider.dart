import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/models/movie.dart';
import 'package:movies/models/now_playing_response.dart';
import 'package:movies/models/popular_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = 'f828c1add3eab569fbb454af8bdebf92';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'en-US';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  int _popularPage = 0;

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_baseUrl, '3/trending/movie/day', {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
    });

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/trending/movie/day');

    final nowPlayingResponse = NowPlayingResponse.fromJson(
      json.decode(jsonData),
    );

    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final jsonData = await _getJsonData('3/tv/popular', _popularPage);

    final popularResponse = PopularResponse.fromJson(
      json.decode(jsonData),
    );

    popularMovies = [...popularResponse.results];
    notifyListeners();
  }
}
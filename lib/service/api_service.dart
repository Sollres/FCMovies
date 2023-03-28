import 'package:dio/dio.dart';

import '../model/genre.dart';
import '../model/movie.dart';

class ApiService {
  final Dio _dio = Dio();

  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey =  'api_key=659562a121c7e022bff79de82f253b68';

  Future<List<Movie>> getNowPlayingMovie() async {
    try {
      print('Api call now playing');
      final response = await _dio.get('$baseUrl/movie/now_playing?$apiKey');
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList; 
    }catch (error, stacktrace) {
      print(error);
      throw Exception('Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Genre>> getGenreList() async {
    try {
      print('Api call genre');
      final response = await _dio.get('$baseUrl/genre/movie/list?$apiKey');
      var genres = response.data['genres'] as List;
      List<Genre> genreList = genres.map((g) => Genre.fromJson(g)).toList();
      return genreList;
    }catch (error, stacktrace) {
      print(error);
      throw Exception('Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

}
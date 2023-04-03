import 'package:dio/dio.dart';
import 'package:films/model/movie_detail.dart';
import 'package:films/model/person.dart';

import '../model/cast_list.dart';
import '../model/genre.dart';
import '../model/movie.dart';
import '../model/movie_image.dart';

class ApiService {
  final Dio _dio = Dio();

  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey =  'api_key=659562a121c7e022bff79de82f253b68';

  Future<List<Movie>> getPopularMovie() async {
    try {
      print('Api call now playing');
      final response = await _dio.get('$baseUrl/movie/popular?$apiKey');
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList; 
    }catch (error, stacktrace) {
      throw Exception('Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Movie>> getNowPlayingMovie() async {
    try {
      print('Api call now playing');
      final response = await _dio.get('$baseUrl/movie_now_playing?$apiKey');
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList; 
    }catch (error, stacktrace) {
      throw Exception('Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Movie>> getMovieByGenre(int movieId) async {
    try {
      print('Api call now playing');
      final response = await _dio.get('$baseUrl/discover/movie?with_genres=$movieId&$apiKey');
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList; 
    }catch (error, stacktrace) {
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

  Future<List<Person>> getTrendingPerson() async {
    try {
      print('Api call trending person');
      final response = await _dio.get('$baseUrl/trending/person/week?$apiKey');
      var persons = response.data['results'] as List;
      List<Person> personList = persons.map((p) => Person.fromJson(p)).toList();
      return personList;
    }catch (error, stacktrace) {
      print(error);
      throw Exception('Exception accoured: $error with stacktrace: $stacktrace');
    }
  }



Future<MovieDetail> getMovieDetail(int movieId) async {
    try {
     
      final response = await _dio.get('$baseUrl/movie/$movieId?$apiKey');
      MovieDetail movieDetail = MovieDetail.fromJson(response.data);
      
      movieDetail.trailerId = await getYoutubeId(movieId);

      movieDetail.movieImage = await getMovieImage(movieId);

      movieDetail.castList = await getCastList(movieId);

      return movieDetail;
    }catch (error, stacktrace) {
      
      throw Exception('Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

Future<String> getYoutubeId(int id) async {
    try {
      final response = await _dio.get('$baseUrl/movie/$id/videos?$apiKey');
      var youtubeId = response.data['results'][0]['key'];
      return youtubeId;
    }catch (error, stacktrace) {
      throw Exception('Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

Future<MovieImage> getMovieImage(int movieId) async {
    try {
      final response = await _dio.get('$baseUrl/movie/$movieId/images?$apiKey');
      return MovieImage.fromJson(response.data);
    }catch (error, stacktrace) {
      throw Exception('Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

Future<List<Cast>> getCastList(int movieId) async {
    try {
      final response = await _dio.get('$baseUrl/movie/$movieId/credits?$apiKey');
      var list = response.data['cast'] as List;
      List<Cast> castList = list.map((c) => Cast(
        name: c['name'],
        profilePath: c['profil_path'],
        character: c['caractere'])).toList();
      return castList;
    }catch (error, stacktrace) {
      throw Exception('Exception accoured: $error with stacktrace: $stacktrace');
    }
}

}
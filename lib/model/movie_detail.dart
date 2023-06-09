import 'package:films/model/cast_list.dart';
import 'package:films/model/movie.dart';
import 'package:films/model/movie_image.dart';

class MovieDetail {
  final String id;
  final String title;
  final String backdropPath;
  final String budget;
  final String homePage;
  final String originalTitle;
  final String overview;
  final String releaseDate;
  final String runtime;
  final String voteAverage;
  final String voteCount;

  late String trailerId;

  late MovieImage movieImage;

  late List<Cast> castList;

  MovieDetail(
      {required this.id,
      required this.title,
      required this.backdropPath,
      required this.budget,
      required this.homePage,
      required this.originalTitle,
      required this.overview,
      required this.releaseDate,
      required this.runtime,
      required this.voteAverage,
      required this.voteCount});

  factory MovieDetail.fromJson(dynamic json) {
    if(json == null) {
      return MovieDetail(id: 'id', title: 'title', backdropPath: 'backdropPath', budget: 'budget', homePage: 'homePage', originalTitle: 'originalTitle', overview: 'overview', releaseDate: 'releaseDate', runtime: 'runtime', voteAverage: 'voteAverage', voteCount: 'voteCount');
    }
    return MovieDetail(
      id: json['id'].toString(),
      title: json['title'],
      backdropPath: json['backdrop_path'],
      budget: json['budget'].toString(),
      homePage: json['home_page'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      runtime: json['runtime'].toString(),
      voteAverage: json['vote_average'].toString(),
      voteCount: json['vote_count'].toString(),
    );
  }
}

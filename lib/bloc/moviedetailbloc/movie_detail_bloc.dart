import 'package:films/bloc/moviebloc/movie_bloc_event.dart';
import 'package:films/bloc/moviedetailbloc/movie_detail_event.dart';
import 'package:films/bloc/moviedetailbloc/movie_detail_state.dart';
import 'package:films/service/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/movie.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc() : super(MovieDetailLoading());

  @override
  Stream<MovieDetailState> mapEventToState(MovieDetailEvent event) async* {
    if(event is MovieDetailEventStarted){
      yield* _mapMovieEventStateToState(event.id);
    }
  }

  Stream<MovieDetailState> _mapMovieEventStateToState(int id) async* {
    final service = ApiService();
    yield MovieDetailLoading();
    try {
      final movieDetail = await service.getMovieDetail(id);

      yield MovieDetailLoaded(movieDetail);
    } on Exception catch (e) {
      print(e);
      yield MovieDetailError();
    }
  }
}
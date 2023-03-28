import 'package:films/bloc/genrebloc/genre_event.dart';
import 'package:films/bloc/genrebloc/genre_state.dart';
import 'package:films/model/genre.dart';
import 'package:films/service/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  GenreBloc() : super(GenreLoading());

  @override
  Stream<GenreState> mapEventToState(GenreEvent event) async* {
    if(event is GenreEventStarted){
      yield* _mapMovieEventStateToState();
    }
  }

  Stream<GenreState> _mapMovieEventStateToState() async* {
    final service = ApiService();
    yield GenreLoading();
    try {
      List<Genre> genreList = await service.getGenreList();
      yield GenreLoaded(genreList);
    } on Exception catch (e) {
      print(e);
      yield GenreError();
    }
  }
}
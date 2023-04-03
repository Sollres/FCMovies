import 'package:films/bloc/personbloc/person_event.dart';
import 'package:films/bloc/personbloc/person_state.dart';
import 'package:films/model/person.dart';
import 'package:films/service/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  PersonBloc() : super(PersonLoading());

  @override
  Stream<PersonState> mapEventToState(PersonEvent event) async* {
    if(event is PersonEventStarted){
      yield* _mapMovieEventStateToState();
    }
  }

  Stream<PersonState> _mapMovieEventStateToState() async* {
    final service = ApiService();
    yield PersonLoading();
    try {
      List<Person> genreList = await service.getTrendingPerson();
      yield PersonLoaded(genreList);
    } on Exception catch (e) {
      print(e);
      yield PersonError();
    }
  }
}
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:films/bloc/moviebloc/movie_bloc_event.dart';
import 'package:films/bloc/moviebloc/movie_bloc_state.dart';
import 'package:films/bloc/personbloc/person_bloc.dart';
import 'package:films/bloc/personbloc/person_event.dart';
import 'package:films/bloc/personbloc/person_state.dart';
import 'package:films/model/person.dart';
import 'package:films/pages/category_screen.dart';
import 'package:films/pages/movie_detail_screen.dart';
import 'package:films/pages/profile_screen.dart';
import 'package:films/pages/sign_up_screen.dart';
import 'package:films/widget/logout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/moviebloc/movie_bloc.dart';
import '../model/movie.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.pushReplacementNamed(context, '/login');
    }
    
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieBloc>(
          create: (_) => MovieBloc()..add(const MovieEventStarted(0, '')),
        ),
        BlocProvider<PersonBloc>(
          create: (_) => PersonBloc()..add(const PersonEventStarted()),
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 75, 71, 65),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const Icon(
            Icons.menu,
            color: Colors.black45,
          ),
          title: Text(
            'FCMovies'.toUpperCase(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'muli',
                ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile(),),);
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(
                      'assets/images/account.png'), //Video 3:27 : https://www.youtube.com/watch?v=K_fwPOKBdZo&t=1872s
                ),
              ),
            ),
          ],
        ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<MovieBloc, MovieState>(
                  builder: (context, state) {
                    if (state is MovieLoading) {
                      return Center(
                        child: Platform.isAndroid
                            ? const CircularProgressIndicator()
                            : const CupertinoActivityIndicator(),
                      );
                    } else if (state is MovieLoaded) {
                      List<Movie> movies = state.movieList;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 45.0, vertical: 5.0),
                            child: Text(
                              'Popular'.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'muli',
                              ),
                            ),
                          ),
                          CarouselSlider.builder(
                            itemCount: movies.length,
                            itemBuilder: (BuildContext context, int index) {
                              Movie movie = movies[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MovieDetailScreen(movie: movie)),
                                  );
                                },
                                child: Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Platform
                                                .isAndroid
                                            ? const CircularProgressIndicator()
                                            : const CupertinoActivityIndicator(),
                                        errorWidget: ((context, url, error) =>
                                            Container(
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/img_not_found.jpg'),
                                                ),
                                              ),
                                            )),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 15,
                                        left: 15,
                                      ),
                                      child: Text(
                                        movie.title.toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          fontFamily: 'muli',
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            options: CarouselOptions(
                              enableInfiniteScroll: true,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 5),
                              autoPlayAnimationDuration: const Duration(
                                microseconds: 800,
                              ),
                              pauseAutoPlayOnTouch: true,
                              viewportFraction: 0.8,
                              enlargeCenterPage: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(
                                  height: 12,
                                ),
                                const BuildWidgetCategory(),
                                Text(
                                  'Trending persons on this week'.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'muli',
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                //Person debut
                                Column(
                                  children: <Widget>[
                                    BlocBuilder<PersonBloc, PersonState>(
                                      builder: (context, state) {
                                        if (state is PersonLoading) {
                                          return Center();
                                        } else if (state is PersonLoaded) {
                                          List<Person> personList =
                                              state.personList;
                                          //print(personList.length);

                                          return Container(
                                            height: 110,
                                            child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: personList.length,
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const VerticalDivider(
                                                color: Colors.transparent,
                                                width: 5,
                                              ),
                                              itemBuilder: (context, index) {
                                                Person person =
                                                    personList[index];

                                                String url = '';

                                                if (person.profilePath !=
                                                    null) {
                                                  url =
                                                      'https://image.tmdb.org/t/p/w200${person.profilePath}';
                                                } else {
                                                  url =
                                                      'https://image.tmdb.org/t/p/original/vVpEOvdxVBP2aV166j5Xlvb5Cdc.jpg';
                                                  index = index + 1;
                                                  print(person.profilePath);
                                                }
                                                return Container(
                                                  child: Column(
                                                    children: <Widget>[
                                                      Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                        ),
                                                        elevation: 3,
                                                        child: ClipRRect(
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                /*'https://image.tmdb.org/t/p/w200${person.profilePath}'*/ url,
                                                            imageBuilder: (context,
                                                                imageProvider) {
                                                              return Container(
                                                                width: 80,
                                                                height: 80,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            100),
                                                                  ),
                                                                  image:
                                                                      DecorationImage(
                                                                    image:
                                                                        imageProvider,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            placeholder:
                                                                (context,
                                                                        url) =>
                                                                    Container(
                                                              width: 80,
                                                              height: 80,
                                                              child: Center(
                                                                child: Platform
                                                                        .isAndroid
                                                                    ? CircularProgressIndicator()
                                                                    : CupertinoActivityIndicator(),
                                                              ),
                                                            ),
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Container(
                                                              width: 80,
                                                              height: 80,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image: AssetImage(
                                                                      'assets/images/img_not_found.jpg'),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Center(
                                                          child: Text(
                                                            person.name
                                                                .toUpperCase(),
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 8,
                                                              fontFamily:
                                                                  'muli',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Center(
                                                          child: Text(
                                                            person
                                                                .knownForDepartment
                                                                .toUpperCase(),
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 8,
                                                              fontFamily:
                                                                  'muli',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                //Person fin
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Container(
                        child: const Text('Something went wrong!!!'),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

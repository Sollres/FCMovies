import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:films/bloc/moviebloc/movie_bloc.dart';
import 'package:films/bloc/moviedetailbloc/movie_detail_bloc.dart';
import 'package:films/bloc/moviedetailbloc/movie_detail_event.dart';
import 'package:films/bloc/moviedetailbloc/movie_detail_state.dart';
import 'package:films/model/movie_detail.dart';
import 'package:films/model/screen_shot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../model/cast_list.dart';
import '../model/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MovieDetailBloc()..add(MovieDetailEventStarted(movie.id)),
      child: WillPopScope(
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 75, 71, 65),
          body: _buildDetailBody(context),
        ),
        onWillPop: () async => true,
      ),
    );
  }

  Widget _buildDetailBody(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
      print('state : ${state}');
      if (state is MovieDetailLoading) {
        return Center(
          child: Platform.isAndroid
              ? const CircularProgressIndicator()
              : const CupertinoActivityIndicator(),
        );
      } else if (state is MovieDetailLoaded) {
        MovieDetail movieDetail = state.detail;
        return Stack(
          children: <Widget>[
            ClipPath(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://image.tmdb.org/t/p/original/${movieDetail.backdropPath}',
                  height: MediaQuery.of(context).size.height / 2.5,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Platform.isAndroid
                      ? const CircularProgressIndicator()
                      : const CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/img_not_found.jpg'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 120),
                  child: GestureDetector(
                    onTap: () async {
                      final youtubeUrl =
                          'https://www.youtube.com/embed/${movieDetail.trailerId}';
                      if (await canLaunch(youtubeUrl)) {
                        await launch(youtubeUrl);
                      }
                    },
                    child: Center(
                        child: Column(
                      children: <Widget>[
                        const Icon(
                          Icons.play_circle_fill_outlined,
                          color: Colors.yellow,
                          size: 65,
                        ),
                        Text(
                          movieDetail.title.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'muli',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context)!.overview.toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 55,
                        child: Text(
                          movieDetail.overview,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'muli',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)!.release.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'muli',
                                      color: Colors.white,
                                    ),
                              ),
                              Text(
                                movieDetail.releaseDate,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        color: Colors.yellow[800],
                                        fontSize: 12,
                                        fontFamily: 'muli'),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)!.length.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'muli',
                                      color: Colors.white,
                                    ),
                              ),
                              Text(
                                movieDetail.runtime,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        color: Colors.yellow[800],
                                        fontSize: 12,
                                        fontFamily: 'muli'),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)!.budget.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'muli',
                                        color: Colors.white,),
                              ),
                              Text(
                                movieDetail.budget,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        color: Colors.yellow[800],
                                        fontSize: 12,
                                        fontFamily: 'muli'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        AppLocalizations.of(context)!.screenshots.toUpperCase(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'muli',
                              color: Colors.white,
                            ),
                      ),
                      Container(
                        height: 155,
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              const VerticalDivider(
                            color: Colors.transparent,
                            width: 5,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: movieDetail.movieImage.backdrops.length,
                          itemBuilder: (context, index) {
                            Screenshot image =
                                movieDetail.movieImage.backdrops[index];
                            return Container(
                              child: Card(
                                elevation: 3,
                                borderOnForeground: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    placeholder: (context, url) => Center(
                                      child: Platform.isAndroid
                                          ? const CircularProgressIndicator()
                                          : const CupertinoActivityIndicator(),
                                    ),
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/w500${image.imagePath}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        AppLocalizations.of(context)!.casts.toUpperCase(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'muli',
                              color: Colors.white,
                            ),
                      ),
                      Container(
                        height: 130,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) =>
                                const VerticalDivider(
                                  color: Colors.transparent,
                                  width: 5,
                                ),
                            itemCount: movieDetail.castList.length,
                            itemBuilder: (context, index) {
                              Cast cast = movieDetail.castList[index];
                              return Container(
                                child: Column(
                                  children: <Widget>[
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      elevation: 3,
                                      child: ClipRRect(
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              /*'https://image.tmdb.org/t/p/w200${cast.profilePath}',*/
                                              'https://image.tmdb.org/t/p/original/vVpEOvdxVBP2aV166j5Xlvb5Cdc.jpg',
                                          imageBuilder:
                                              (context, imageBuilder) {
                                            return Container(
                                              width: 80,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(100)),
                                                image: DecorationImage(
                                                  image: imageBuilder,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            );
                                          },
                                          placeholder: (context, url) =>
                                              Container(
                                            width: 80,
                                            height: 80,
                                            child: Center(
                                              child: Platform.isAndroid
                                                  ? const CircularProgressIndicator()
                                                  : const CupertinoActivityIndicator(),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            width: 80,
                                            height: 80,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
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
                                          cast.name.toUpperCase(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 8,
                                              fontFamily: 'muli'),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: const Center(
                                        child: Text(
                                          'cast.character',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 8,
                                              fontFamily: 'muli'),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        );
      } else {
        return Container(color: Colors.yellow);
      }
    });
  }
}
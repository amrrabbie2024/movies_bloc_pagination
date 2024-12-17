part of 'bloc.dart';

class MoviesStaes{}

class MoviesLoadingState extends MoviesStaes{}

class MoviesFailedState extends MoviesStaes{
  final String msg;

  MoviesFailedState({required this.msg});
}

class MoviesSuccessState extends MoviesStaes{
  final List<MovieModel> moviesList;

  MoviesSuccessState({required this.moviesList});
}

class MoviesPaginationState extends MoviesStaes{
  final String? msg;

  MoviesPaginationState({this.msg});
}

class MoviesPaginationFinishedState extends MoviesStaes{
  final String? msg;

  MoviesPaginationFinishedState({this.msg});
}
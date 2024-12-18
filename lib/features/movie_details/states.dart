part of 'bloc.dart';

class MovieDetailsStates{}

class MovieDetailsLoadingState extends MovieDetailsStates{}

class MovieDetailsFailedState extends MovieDetailsStates{
  final String msg;

  MovieDetailsFailedState({required this.msg});
}

class MovieDetailsSuccessState extends MovieDetailsStates{
  final MovieDetailsData movieData;

  MovieDetailsSuccessState({required this.movieData});
}
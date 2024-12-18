part of 'bloc.dart';

class MovieDetailsEvents{}

class GetMovieDetailsEvent extends MovieDetailsEvents{
  final int id;

  GetMovieDetailsEvent({required this.id});
}
import 'package:flutter_movies_bloc/features/movies/bloc.dart';
import 'package:get_it/get_it.dart';

void initGetIt(){
  final getit=GetIt.instance;

  getit.registerFactory(() => MoviesBloc());

}
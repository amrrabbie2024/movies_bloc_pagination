import 'package:flutter_movies_bloc/features/movies/bloc.dart';
import 'package:kiwi/kiwi.dart';

void initKiwi(){
  final kiwi=KiwiContainer();

  kiwi.registerFactory((container) => MoviesBloc());

}
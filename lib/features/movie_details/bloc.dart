import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_movies_bloc/core/constants.dart';
import 'package:flutter_movies_bloc/core/logic/dio_helper.dart';

part 'model.dart';
part 'states.dart';
part 'events.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvents,MovieDetailsStates>{
  MovieDetailsBloc():super(MovieDetailsLoadingState()){
    on<GetMovieDetailsEvent>(_getMovieDetails);
  }


  Future<void> _getMovieDetails(GetMovieDetailsEvent event, Emitter<MovieDetailsStates> emit) async {
    
    final response=await DioHelper.get("movie/${event.id}",data: {
      "api_key":Constants.Movies_Api_key
    });

    if(response.isSucess){
      final model=MovieDetailsData.fromJson(response.data);
      emit(MovieDetailsSuccessState(movieData: model));
    }else{
      print("Error:- ${response.msg}");
      emit(MovieDetailsFailedState(msg: response.msg));
    }
  }
}
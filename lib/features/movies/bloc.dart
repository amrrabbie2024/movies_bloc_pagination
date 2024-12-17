import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_movies_bloc/core/constants.dart';
import 'package:flutter_movies_bloc/core/logic/dio_helper.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';


class MoviesBloc extends Bloc<MoviesEvents,MoviesStaes>{
  MoviesBloc():super(MoviesStaes()){
    on<GetMoviesDataEvent>(_getMoviesData);
  }
  
  List<MovieModel> _list=[];
  bool isFromLoading=true;
  bool isFromPagination=false;
  int currentPage=1;
  

  Future<void> _getMoviesData(GetMoviesDataEvent event, Emitter<MoviesStaes> emit) async {
    if(isFromLoading){
      isFromLoading=false;
      isFromPagination=true;
      emit(MoviesLoadingState());
    }else if(isFromPagination){
      emit(MoviesPaginationState(msg: "More data is loading ..."));
    }


    
    final response=await DioHelper.get("discover/movie",data: {
      "api_key":Constants.Movies_Api_key,
      "page":currentPage
    });

    if(response.isSucess){
      final model=MoviesData.fromJson(response.data);

      //if(model.totalPages > currentPage){
      if(5 > currentPage){
        currentPage++;
        _list.addAll(model.movies);
        emit(MoviesSuccessState(moviesList: _list));
      }else{
        emit(MoviesPaginationFinishedState(msg: "No more data aviable !"));
      }
    }else{
      print("Error:- ${response.msg}");
      emit(MoviesFailedState(msg: response.msg));
    }
  }
}
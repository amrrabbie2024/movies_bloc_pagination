part of '../view.dart';
class MoviesGrid extends StatefulWidget {
  const MoviesGrid({super.key});

  @override
  State<MoviesGrid> createState() => _MoviesGridState();
}

final gbloc=GetIt.I<MoviesBloc>();

class _MoviesGridState extends State<MoviesGrid> {
  @override
  void initState() {
    gbloc.add(GetMoviesDataEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: gbloc,
      buildWhen: (previous, current) => current is MoviesSuccessState || current is MoviesFailedState || current is MoviesLoadingState,
      listener: (context, state) {
        if(state is MoviesFailedState)
          showMessage(state.msg);
        else if(state is MoviesSuccessState)
          showMessage("Items:- ${state.moviesList.length}",isSucess: true);
        else if(state is MoviesPaginationFinishedState)
          showMessage(state.msg!);
        else if(state is MoviesPaginationState)
          showProgressDialog(state.msg!);
      },
      builder: (context, state) {
        if(state is MoviesFailedState)
          return AppFailed(msg: state.msg);
        else if(state is MoviesSuccessState)
          return _grid(state.moviesList);
        else
          return AppLoading();
      },
    );
  }

  Widget _grid(List<MovieModel> moviesList) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if(notification.metrics.pixels == notification.metrics.maxScrollExtent && notification is ScrollUpdateNotification){
          gbloc.add(GetMoviesDataEvent());
        }
        return true;
      },
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 16.h,
            childAspectRatio: .8
          ),
          itemBuilder: (context, index) =>  _gridItem(moviesList[index]),
      itemCount: moviesList.length,),
    );
  }

  Widget _gridItem(MovieModel movie) {
    return GestureDetector(
      onTap: () {
        print(movie.title);
      },
      child: Card(
        //color: Colors.grey.withOpacity(.5),
        shadowColor: Colors.orange,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r),topRight: Radius.circular(20.r)),
          side: BorderSide(color: Theme.of(context).primaryColor)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(20.r),child: Image.network(Constants.Movies_Base_Url + movie.posterPath,width: MediaQuery.of(context).size.width,height: 160.h,fit: BoxFit.fill,)),
            SizedBox(height: 8.h,),
            Text(movie.title,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w600,fontSize: 24),)
          ],
        ),
      ),
    );
  }
}

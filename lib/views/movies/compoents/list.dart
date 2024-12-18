part of '../view.dart';
class MoviesList extends StatefulWidget {
  const MoviesList({super.key});

  @override
  State<MoviesList> createState() => _MoviesListState();
}

final kbloc=KiwiContainer().resolve<MoviesBloc>();

class _MoviesListState extends State<MoviesList> {
  @override
  void initState() {
    kbloc.add(GetMoviesDataEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: kbloc,
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
          return Center(child: Text(state.msg,style: TextStyle(color: Colors.red,fontSize: 24,fontWeight: FontWeight.bold),));
        else if(state is MoviesSuccessState)
          return _list(state.moviesList);
        else
          return Center(child: CupertinoActivityIndicator(radius: 35.r,color: Colors.orange,));
      },
    );
  }

  Widget _list(List<MovieModel> moviesList) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if(notification.metrics.pixels == notification.metrics.maxScrollExtent && notification is ScrollUpdateNotification){
          kbloc.add(GetMoviesDataEvent());
        }
        return true;
      },
      child: ListView.separated(
          itemBuilder: (context, index) =>  _listItem(moviesList[index]),
          separatorBuilder: (context, index) => Divider(thickness: 3.h,indent: 35.w,endIndent: 35.w,color: Theme.of(context).primaryColor,), 
          itemCount: moviesList.length
      ),
    );
  }

  Widget _listItem(MovieModel movie) {
    return InkWell(
      onTap: () {
        print(movie.title);
        Navigator.push(context,  MaterialPageRoute(builder: (context) => MovieDetails(id: movie.id, title: movie.title),));
      },
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          //color: Colors.grey.withOpacity(.5),
          borderRadius: BorderRadius.circular(20.r)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(20.r),child: Image.network(Constants.Movies_Base_Url + movie.posterPath,width: double.infinity,height: 180.h,fit: BoxFit.fill,)),
            SizedBox(height: 4.h,),
            Text(movie.title,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w600,fontSize: 24))
          ],
        ),
      ),
    );
  }

  void _showProgressDialog(String? msg) {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(milliseconds: 500), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 8.h,),
                Text(msg!, style: TextStyle(color: Theme
                    .of(context)
                    .primaryColor, fontWeight: FontWeight.bold, fontSize: 21),),
              ],
            ),
          );
        });
  }
}

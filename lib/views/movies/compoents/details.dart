part of '../view.dart';
class MovieDetails extends StatefulWidget {
  final int id;
  final String title;
  const MovieDetails({super.key, required this.id, required this.title});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

final gggbloc=GetIt.I<MovieDetailsBloc>();

class _MovieDetailsState extends State<MovieDetails> {
  @override
  void initState() {
    gggbloc.add(GetMovieDetailsEvent(id: widget.id));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder(
        bloc: gggbloc,
        builder: (context, state) {
          if(state is MovieDetailsFailedState)
            return AppFailed(msg: state.msg);
          else if(state is MovieDetailsSuccessState)
            return _details(state.movieData);
          else
            return AppLoading();
        },
      ),
    );
  }

  Widget _details(MovieDetailsData movie) {
    return Card(
      margin: EdgeInsetsDirectional.symmetric(horizontal: 8.w,vertical: 8.w),
      shadowColor: Colors.orange,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(20.r),topLeft: Radius.circular(20.r)),
        side: BorderSide(color: Theme.of(context).primaryColor)
      ),
      child: SingleChildScrollView(
        padding:  EdgeInsets.all(8.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(20.r),child: Image.network(Constants.Movies_Base_Url+movie.posterPath,width: MediaQuery.of(context).size.width,height: 380.h,fit: BoxFit.fill,)),
            SizedBox(height: 8.h,),
            Text(movie.title,style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 24),),
            SizedBox(height: 8.h,),
            Text(movie.overview,style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.5),fontWeight: FontWeight.normal,fontSize: 20),),
            SizedBox(height: 8.h,),
            Text(movie.releaseDate,style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 24),),
            SizedBox(height: 8.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star,color: Colors.amber,size: 32.r,),
                SizedBox(width: 4.w,),
                Text(movie.voteAverage.toString(),style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 24),),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

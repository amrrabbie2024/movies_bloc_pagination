part of '../view.dart';
class MoviesCarsoal extends StatefulWidget {
  const MoviesCarsoal({super.key});

  @override
  State<MoviesCarsoal> createState() => _MoviesCarsoalState();
}

final ggbloc=GetIt.I<MoviesBloc>()..add(GetMoviesDataEvent());
int mcurrentIndex=0;

class _MoviesCarsoalState extends State<MoviesCarsoal> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 8.w,vertical: 16.h),
      child: BlocBuilder(
        bloc: ggbloc,
        builder: (context, state) {
          if(state is MoviesFailedState)
            return AppFailed(msg: state.msg);
          else if(state is MoviesSuccessState)
            return _carsoal(state.moviesList);
          else
            return AppLoading();
        },
      ),
    );
  }

  Widget _carsoal(List<MovieModel> moviesList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CarouselSlider(
          items: List.generate(moviesList.length, (index) => _carsoalItem(moviesList[index])),
          options: CarouselOptions(
            height: 450.h,
             enlargeCenterPage: true,
            autoPlayInterval: Duration(seconds: 2),
            autoPlayAnimationDuration: Duration(milliseconds: 300),
            autoPlay: true,
            reverse: true,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                mcurrentIndex=index;
              });
            },
          ),
        ),
        SizedBox(height: 4.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(moviesList.length, (index) => _indictorItem(index))
          ],
        )
      ],
    );
  }

  _carsoalItem(MovieModel movie) {
    return GestureDetector(
      onTap: () {
        print(movie.title);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.network(Constants.Movies_Base_Url+movie.posterPath,width: double.infinity,height: 360.h,fit: BoxFit.fill,)),
          SizedBox(height: 8.h,),
          Text(movie.title,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.bold),),
        ],
      ),
    ) ;
  }

  _indictorItem(int index) {
    return CircleAvatar(radius: 8.r,backgroundColor: index==mcurrentIndex?Colors.orange:Colors.transparent,child: CircleAvatar(radius: 7.r,backgroundColor: index==mcurrentIndex?Theme.of(context).primaryColor:Colors.grey,));
  }
}

part of '../view.dart';
class MoviesDropDown extends StatefulWidget {
  const MoviesDropDown({super.key});

  @override
  State<MoviesDropDown> createState() => _MoviesDropDownState();
}

final kkbloc=KiwiContainer().resolve<MoviesBloc>();
int? currentMovie;

class _MoviesDropDownState extends State<MoviesDropDown> {
  @override
  void initState() {
    kkbloc.add(GetMoviesDataEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 8.w,vertical: 8.h),
          child: BlocBuilder(
            bloc: kkbloc,
            builder: (context, state) {
              if(state is MoviesFailedState)
                return AppFailed(msg: state.msg);
              else if(state is MoviesSuccessState)
                return _ddbList(state.moviesList);
              else
                return AppLoading();
            },
          ),
        ),
      ),
    );
  }

  Widget _ddbList(List<MovieModel> moviesList) {
    return DropdownButton(
      isExpanded: true,
      autofocus: true,
      underline: SizedBox(),
      borderRadius: BorderRadius.circular(20.r),
      focusColor: Colors.yellow,
      dropdownColor: Colors.yellow,
      icon: Icon(Icons.search,color: Colors.orange,),
      iconSize: 32.r,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 8.w),

      value: currentMovie,
        items: List.generate(moviesList.length, (index) => _ddbListItem(moviesList[index])),
        onChanged: (value) {
        setState(() {
          currentMovie=value!;
          //Navigator.push(context, MaterialPageRoute(builder:  (context) => MovieDetails(id: moviesList[value].id, title: moviesList[value].title),));
        });
        },);
  }

  _ddbListItem(MovieModel movie) {
    return DropdownMenuItem(child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(radius: 25.r,backgroundImage: NetworkImage(Constants.Movies_Base_Url+movie.posterPath)),
        Text(movie.title,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 17,fontWeight: FontWeight.normal),)
      ],
    ),value: movie.id,);
  }
}

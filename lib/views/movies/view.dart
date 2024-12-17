import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_bloc/core/constants.dart';
import 'package:flutter_movies_bloc/core/design/failed.dart';
import 'package:flutter_movies_bloc/core/design/loading.dart';
import 'package:flutter_movies_bloc/core/logic/helper_methods.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:kiwi/kiwi.dart';

import '../../core/design/drawyer.dart';
import '../../features/movies/bloc.dart';
part 'compoents/list.dart';
part 'compoents/grid.dart';
part 'compoents/dropdown.dart';
part 'compoents/carsoal.dart';

class MoviesView extends StatefulWidget {
  const MoviesView({super.key});

  @override
  State<MoviesView> createState() => _MoviesViewState();
}

int currentIndex=0;

class _MoviesViewState extends State<MoviesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("movie_app".tr()),
        actions: [
          IconButton(onPressed: () {
            navigateTo(MoviesDropDown(),withHistory: true);
          }, icon: Icon(Icons.search,size: 32,color: Theme.of(context).primaryColor,))
        ],
      ),
      drawer: DrawyerApp(),
      bottomNavigationBar:  _bottomNavigationBar(),
      floatingActionButton: _floatingActionButton(),
      body: Builder(builder: (context) {
        if(currentIndex == 0)
          //return Center(child: Text("List",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.bold),));
          return MoviesList();
        else if(currentIndex == 1)
         // return Center(child: Text("Grid",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.bold),));
          return MoviesGrid();
        else if(currentIndex == 2)
          //return Center(child: Text("Carsoal",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.bold),));
          return MoviesCarsoal();
        else
          //return Center(child: Text("List",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.bold),));
          return MoviesList();
      },),
    );
  }

  Widget _bottomNavigationBar() {
    return ClipRRect(
      borderRadius: BorderRadius.only(topRight: Radius.circular(24.r),topLeft: Radius.circular(24.r)),
      child: BottomNavigationBar(
        backgroundColor: Colors.orange.withOpacity(.5),
        iconSize: 32.r,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 22,
        unselectedFontSize: 15,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.yellow,
        onTap: (value) {
          setState(() {
            currentIndex=value;
          });
        },
        items: [
           BottomNavigationBarItem(icon: Icon(Icons.list),label: "List"),
          BottomNavigationBarItem(icon: Icon(Icons.grid_4x4_rounded),label: "Grid"),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt),label: "Carsoal"),
        ],
      ),
    );
  }

  _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(.5),
      child: Icon(Icons.search,size: 32.r,color: Colors.orange,),
      shape: CircleBorder(
        side: BorderSide(color: Colors.orange)
      ),
      onPressed: () {
        navigateTo(MoviesDropDown(),withHistory: true);
    },);
  }
}

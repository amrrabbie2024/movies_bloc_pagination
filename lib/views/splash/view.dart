import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies_bloc/core/logic/helper_methods.dart';
import 'package:flutter_movies_bloc/views/movies/view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      navigateTo(MoviesView() ,withHistory: false);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeInDownBig(
          duration: Duration(seconds: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Image.asset("assets/images/logo.png",width: 180.w,height: 160.h,fit: BoxFit.fill,),
              SvgPicture.asset("assets/svg/movies.svg",width: 180.w,height: 160.h,fit: BoxFit.fill,),
              SizedBox(height: 8.h,),
              Text("movie_app".tr(),style: TextStyle(color: Theme.of(context).primaryColor,fontFamily: "PlaywriteNZ",fontSize: 24,fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ),
    );
  }
}

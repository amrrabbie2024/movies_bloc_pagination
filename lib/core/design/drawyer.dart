import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies_bloc/core/logic/helper_methods.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../views/change_language/view.dart';

class DrawyerApp extends StatelessWidget {
  const DrawyerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 240.w,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(20.r)),
        side: BorderSide(color: Theme.of(context).primaryColor)
      ),
      shadowColor: Colors.orange.withOpacity(.3),
      elevation: 32,
      backgroundColor: Theme.of(context).primaryColor.withOpacity(.1),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 48.h,),
            CircleAvatar(radius: 50.r,backgroundColor: Theme.of(context).primaryColor,child: CircleAvatar(radius: 48.r,backgroundImage: AssetImage("assets/images/logo.png"),)),
            SizedBox(height: 8.h,),
            Text("movie_app".tr(),style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.bold),),
            SizedBox(height: 24.h,),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: TextButton(onPressed: () {
                navigateTo(ChangeLanguageView(),withHistory: true);
              }, child: Text("change_language".tr())),
            ),
          ],
        ),
      ),
    );
  }
}

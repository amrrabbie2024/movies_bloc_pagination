import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

final navigtorKey=GlobalKey<NavigatorState>();

/*void navigateTo(Widget page){
  Navigator.push(navigtorKey.currentContext!, MaterialPageRoute(builder: (context) => page,));
}*/

void navigateTo(Widget page,{bool withHistory=true}){
  Navigator.pushAndRemoveUntil(navigtorKey.currentContext!, MaterialPageRoute(builder: (context) => page,),(route) => withHistory,);
}

void showMessage(String msg,{bool isSucess=false}){
  if(msg != null) {
    ScaffoldMessenger.of(navigtorKey.currentContext!).showSnackBar(SnackBar(
        backgroundColor: isSucess == true ? Colors.green : Colors.red,

        content: Center(child: Text(msg))));
  }
}

 void showProgressDialog(String? msg) {
  showDialog(
      context: navigtorKey.currentContext!,
      builder: (context) {
        Future.delayed(Duration(seconds: 1), () {
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

Future uploadImageToApi(XFile img) async {
  return MultipartFile.fromFile(
    img.path,
    filename: img.path
        .split('/')
        .last,
  );
}


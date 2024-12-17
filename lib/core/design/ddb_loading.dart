import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DDBLoading extends StatelessWidget {
  const DDBLoading({super.key});

  @override
  Widget build(BuildContext context) {

    return Center(
      child: CircularProgressIndicator(
        color: Colors.orange,
        backgroundColor: Colors.yellow,
        strokeWidth: 3.r,
      ),
    );
  }
}

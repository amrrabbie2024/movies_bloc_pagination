import 'package:flutter/material.dart';

class AppFailed extends StatelessWidget {
  final String msg;
  const AppFailed({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Text(
      msg,
      style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 28),
    );
  }
}

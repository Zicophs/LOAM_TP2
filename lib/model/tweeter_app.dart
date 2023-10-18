import 'package:flutter/material.dart';
import 'package:fwitter/model/flutter_list.dart';

class MyTwitterApp extends StatelessWidget {
  const MyTwitterApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: FlutterList()
        ),
      );
  }
}
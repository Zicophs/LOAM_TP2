import 'package:flutter/material.dart';
import 'package:fwitter/model/tweeter_app.dart';
import 'package:fwitter/screens/second_screen.dart';


class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MyTwitterApp(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
        shape: CircleBorder(),
        onPressed: () {
          // Navegar a la segunda pantalla
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => SecondScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

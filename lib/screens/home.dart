import 'package:flutter/material.dart';
import 'package:fwitter/model/flutter_list.dart';
import 'package:fwitter/screens/new_tweet.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: FlutterList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
        shape: CircleBorder(),
        onPressed: () {
          // Navegar a la segunda pantalla
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => NewTweetScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

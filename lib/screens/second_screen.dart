import 'package:flutter/material.dart';
import 'package:fwitter/screens/create_tweet.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Create Tweet'),
      ),
      body: Center(
        child: EscribirTweet(),
      ),
    );
  }
}
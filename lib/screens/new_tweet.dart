import 'package:flutter/material.dart';
import 'package:fwitter/services/create_tweet.dart';

class NewTweetScreen extends StatelessWidget {
  const NewTweetScreen({super.key});

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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EscribirTweet extends StatefulWidget {
  const EscribirTweet({super.key});

  @override
  _EscribirTweetState createState() => _EscribirTweetState();
}

class _EscribirTweetState extends State<EscribirTweet> {
  final TextEditingController tweetController = TextEditingController();
  final firestoreInstance = FirebaseFirestore.instance;

  void enviarTweet() {
    String tweetText = tweetController.text;
    if (tweetText.length <= 250) {
      
      firestoreInstance.collection('fwitters').add({
        'user': 'Nico',
        'post': tweetText,
        'date': DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()),
        'likes': 0,
      });

    }else {
      
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('El tweet no puede superar los 250 caracteres.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }  

    tweetController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: tweetController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'What are you thinking?',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: enviarTweet,
              child: const Text('Send Tweet'),
            ),
          ],
        ),
      ),
    );
  }
}

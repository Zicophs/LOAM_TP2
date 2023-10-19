import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fwitter/model/fwitter.dart';
import 'package:fwitter/model/flutter_item.dart';


class FlutterList extends StatefulWidget {
  const FlutterList({Key? key}) : super(key: key);
  @override
  _FlutterListState createState() => _FlutterListState();
}

class _FlutterListState extends State<FlutterList>{
  final fwittersRef = FirebaseFirestore.instance
  .collection('fwitters')
  .withConverter<Fwitter>(
      fromFirestore: (snapshots, _) => Fwitter.fromJson(snapshots.data()!),
      toFirestore: (fwitter, _) => fwitter.toJson(),
      );

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Fwitter", style: TextStyle(fontWeight: FontWeight.bold)),
        
      ),
      body: StreamBuilder<QuerySnapshot<Fwitter>>(
        stream: fwittersRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final data = snapshot.requireData;
          
          return ListView.builder(
            itemCount: data.size,
            itemBuilder:(context, index) {
              return FlutterItem(
                data.docs[index].data(),
                data.docs[index].reference,
              );  
            }, 
          );
        }
      ),
    );
  }
}
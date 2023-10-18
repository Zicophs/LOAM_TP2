import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fwitter/model/avatar.dart';
import 'package:fwitter/model/fwitter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


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
              return _FlutterItem(
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

class _FlutterItem extends StatelessWidget{
  
  final Fwitter fwitter;
  final DocumentReference<Fwitter> reference;
  double rating = 0;

  _FlutterItem(this.fwitter,this.reference){
    rating = fwitter.likes.toDouble();
  }

  Widget get user {
    return Text(
      fwitter.user,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Widget get datepost {
    return Text(
      fwitter.date,
      style: const TextStyle(color: Colors.grey, fontSize: 12),
    );
  }

  Widget get likes {
    return Text(
      fwitter.likes.toString(),
      style: const TextStyle(color: Colors.grey, fontSize: 12),
    );
  }

  Widget get title {
    return Text(
      fwitter.post,
      style: const TextStyle(fontSize: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Avatar(),
                Text('  '),
                user,
              ],
            ),
            SizedBox(height: 8),
            title,
            SizedBox(height: 12),
            Row(
              children: [
                Text('Puntaje: '),
                likes,
                Text('    '),
                RatingBar.builder(
                  initialRating: rating, // Puntuación inicial (puedes ajustarla según tus necesidades)
                  minRating: 1, // Puntuación mínima
                  direction: Axis.horizontal, // Dirección de las estrellas
                  allowHalfRating: false, // Permite puntuación decimal
                  itemCount: 5, // Número de estrellas
                  itemSize: 14, // Tamaño de las estrellas
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber, // Color de las estrellas
                  ),
                  onRatingUpdate: (newRating) async {
                    // Actualiza la variable de puntuación
                    rating = newRating;
                    // Actualiza el número de "likes" en Firestore
                    await reference.update({
                      'likes': newRating.toInt(), // Convierte la puntuación a entero
                    });
                    setState(() {
                      rating = newRating;
                    });

                  },
                ),
                Text('    '),
                Icon(Icons.calendar_month_outlined, color: Colors.grey, size: 14),
                datepost,
              ]
            ),
          ],
        ),
      ),
    ); 
  }
  
  void setState(Null Function() param0) {}
}

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getImage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          //final imgURL = snapshot.data;
          return CircleAvatar(
            radius: 15,
            /*child: Image.network(
              imgURL.toString(),
              fit: BoxFit.cover, // Ajusta el contenido de la imagen para cubrir el círculo
            ),*/
            //backgroundImage: NetworkImage(imgURL.toString()),
            //backgroundImage: NetworkImage("https://firebasestorage.googleapis.com/v0/b/prueba-dfe12.appspot.com/o/N.png?alt=media&token=b30c729b-ecd1-46f0-bbc7-b2bd430df9f7"),
            backgroundImage:  NetworkImage(imageUrl),
          );
        } else {
          return const CircularProgressIndicator(); // Muestra un indicador de carga mientras se descarga la imagen
        }
      },
    );
  }

  Future<String> getImage() async {
    final storageRef = FirebaseStorage.instance.ref('gs://prueba-dfe12.appspot.com');
    //final imageUrl = await storageRef.child("pochita.jpg").getDownloadURL();
    final imageUrl = await storageRef.child("N.png").getDownloadURL();
    return imageUrl;
  }
}


String imageUrl = "https://firebasestorage.googleapis.com/v0/b/prueba-dfe12.appspot.com/o/N.png?alt=media&token=b30c729b-ecd1-46f0-bbc7-b2bd430df9f7";
Widget get imagen{
  return Image.network(imageUrl);
}

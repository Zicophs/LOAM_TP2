import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Avatar extends StatelessWidget {
  const Avatar({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getImageUrl(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          final imageUrl = snapshot.data;

          return CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(imageUrl.toString()),
          );
        } else if (snapshot.hasError) {
          return const SizedBox(); // Muestra un indicador de carga mientras se descarga la imagen
        } else {
          return const SizedBox(); // Muestra un indicador de carga mientras se descarga la imagen
        }
      },
    );
  }

  Future<String> getImageUrl() async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child('N.png'); // Reemplaza 'N.png' con el nombre de tu imagen en Firebase Storage
      final imageUrl = await storageRef.getDownloadURL();
      return imageUrl;
    } catch (error) {
      print('Error al cargar la imagen: $error');
      return ''; // Devuelve una URL de imagen de marcador de posición o una URL válida predeterminada
    }
  }
}

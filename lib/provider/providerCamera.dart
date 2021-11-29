import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProviderCamera with ChangeNotifier {
  late CameraController controller;
  late Future<void> initializeControllerFuture;

  //dps colocar dentro de uma classe de constantes
  String baseUrl = 'https://face-b60c2-default-rtdb.firebaseio.com/';

  // Esse método vai ser usado lá no "exemplo.dart" q seria o "regScreen".
  // Basicamente só precisa mandar a foto em Base64 e dps colocar ela numa var tipo File
  //quando usar ela aqui
  Future<void> metodoEnviaColabBD(String image, String nome) async {
    File imageFile = new File(image);
    List<int> imageBytes = imageFile.readAsBytesSync();
    // depois só usar base64Decode no inverso...
    String base64Image = base64Encode(imageBytes);

    final response = await http.post(
      Uri.parse('$baseUrl/novoRegistro.json'),
      //Aqui tmbm poderia ser colocado try e tal
      body: jsonEncode(
        {
          'nome': nome,
          'imageUrl': base64Image,
        },
      ),
    );
/*
    _items.add(
      Product(
        // response.body é o id do obj (retorno) do servidor com 'name'
        id: jsonDecode(response.body)['name'],
        description: newProduct.description,
        title: newProduct.title,
        price: newProduct.price,
        imageUrl: newProduct.imageUrl,
      ),
    );
    // Precisa  notificar pq aqui é "criado" os itens q vem do servidor.
    notifyListeners();
    */
  }
}

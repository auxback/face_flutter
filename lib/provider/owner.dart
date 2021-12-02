import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:face_teste/models/colab.dart';
import 'package:face_teste/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OwnerProvider with ChangeNotifier {
  //dps colocar dentro de uma classe de constantes
  String baseUrl = Constants.BASE_API_URL;

  List<Colab> colabs = [];

  //----------------------------------------------------------------------------

  // Esse método vai ser usado lá no "exemplo.dart" q seria o "regScreen".
  // Basicamente só precisa mandar a foto em Base64 e dps colocar ela numa var tipo File
  //quando usar ela aqui
  Future<void> addColab(String name, File image) async {
    /*
    File imageFile = new File(image);
    List<int> imageBytes = imageFile.readAsBytesSync();
    // depois só usar base64Decode no inverso...
    String base64Image = base64Encode(imageBytes);

    final response = await http.post(
      Uri.parse('$baseUrl/novoRegistro.json'),
      //Aqui tmbm poderia ser colocado try e tal
      body: jsonEncode(
        {
          'nome': name,
          'imageUrl': base64Image,
        },
      ),
    );
    */
    //arquivo local q vem lá do formul
    File imageFile = image;

    List<int> imageBytes = imageFile.readAsBytesSync();

    // depois só usar base64Decode no inverso...
    String base64Image = base64Encode(imageBytes);

    Random random = new Random();

    colabs.add(
      Colab(
        // (SERVIDOR) response.body é o id do obj (retorno) do servidor com 'name'
        //id: jsonDecode(response.body)['name'], image: imageFile, name: name,
        //
        // (TESTE) Vai guardar o "nome" e a foto em base64 como String
        id: random.nextInt(100).toString(),
        name: name,
        image: base64Image,
      ),
    );
    // Precisa  notificar pq aqui é "criado" os itens q vem do servidor.
    notifyListeners();
  }
}

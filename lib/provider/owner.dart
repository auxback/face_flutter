import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'dart:typed_data';
import 'package:face_teste/models/colab.dart';
import 'package:face_teste/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class OwnerProvider with ChangeNotifier {
  //dps colocar dentro de uma classe de constante
  String baseUrl = Constants.BASE_API_URL;

  List<Colab> colabs = [];

  //----------------------------------------------------------------------------

  // Esse método vai ser usado lá no "exemplo.dart" q seria o "regScreen".
  // Basicamente só precisa mandar a foto em Base64 e dps colocar ela numa var tipo File
  //quando usar ela aqui
  Future<void> addColab(String name, File image) async {
    /*
    //--------------------------------------------------------------------------
    // Passo arquivo do tipo File p/ Base64. Dps envia pra o servidor
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
    //--------------------------------------------------------------------------
    */
    //arquivo local q vem lá do formul
    File imageFile = image;

    //--------------------------------------------------------------------------------------------------------
    // CONVERTE DE BASE64 PRA ARQUIVO
    //É passado a string base64, pego o caminho onde vai ser armazenado, criado o nome do arquivo
    //com o caminho desse arquivo e criado um arquivo do tipo File (q tem o caminho desse arquivo). Dps retorna o caminho.
    Future<String> _createFileFromString(/*aqui coloco o obj*/) async {
      final encodedStr = "put base64 encoded string here";
      Uint8List bytes = base64.decode(encodedStr);
      String dir = (await getApplicationDocumentsDirectory()).path;
      File file = File(
          "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".jpeg");
      await file.writeAsBytes(bytes);
      return file.path;
    }
    //--------------------------------------------------------------------------------------------------------

    List<int> imageBytes = imageFile.readAsBytesSync();

    // depois só usar base64Decode no inverso...
    String base64Image = base64Encode(imageBytes);

    //tmbm é do tipo "Uint8list"
    base64Decode(base64Image);

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

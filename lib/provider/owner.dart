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

  
}

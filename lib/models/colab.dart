import 'dart:io';

class Colab {
  final String id;
  final String name;
  final File image;

  Colab({
    required this.name,
    required this.image,
    required this.id,
  });
}

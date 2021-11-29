import 'dart:io';

import 'package:flutter/material.dart';

class Anexo extends StatelessWidget {
  final File arquivo;

  Anexo(this.arquivo);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24),
      child: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: ClipRRect(
            child: Image.file(
              arquivo,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }
}

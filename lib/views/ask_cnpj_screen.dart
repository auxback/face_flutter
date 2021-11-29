import 'package:face_teste/utils/app_routes.dart';
import 'package:flutter/material.dart';

class AskCnpjScreen extends StatelessWidget {
  AskCnpjScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'CROOB',
            ),
          ),
          SizedBox(
            height: 180,
          ),
          Text('CNPJ da sua loja'),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'CNPJ'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.CNPJ_HOME_SCREEN);
            },
            child: Text('ACESSAR'),
          ),
        ],
      ),
    );
  }
}

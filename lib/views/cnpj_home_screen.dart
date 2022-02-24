import 'package:face_teste/provider/owner.dart';
import 'package:face_teste/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CnpjHomeScreen extends StatelessWidget {
  CnpjHomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 80,
          ),
          Row(
            children: [
              Expanded(
                  child: Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text('Bem vindo(a): Loja XXXX'),
                  SizedBox(
                    width: 30,
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.ASK_CNPJ_SCREEN);
                      },
                      child: Text('SAIR'),
                    ),
                  ),
                ],
              )),
            ],
          ),
          SizedBox(
            height: 200,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('CADASTRAR \n COLABORADOR'),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.COLAB_REG_SCREEN);
                    },
                    child: Text('CADASTRO'),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Text('COLABORADORES \n CADASTRADOS'),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.COLAB_REG_SCREEN);
                    },
                    child: Text('ACESSAR'),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

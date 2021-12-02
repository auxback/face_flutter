import 'package:camera/camera.dart';
import 'package:face_teste/provider/providerCamera.dart';
import 'package:face_teste/utils/app_routes.dart';
import 'package:face_teste/views/ask_cnpj_screen.dart';
import 'package:face_teste/views/cnpj_home_screen.dart';
import 'package:face_teste/views/colabs_screen.dart';
//import 'package:face_teste/views/providerCamera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/colab_reg_screen.dart';

//late CameraDescription firstCamera;
Future<void> main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //final cameras = await availableCameras();
  //firstCamera = cameras.first;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ProviderCamera(),
      child: MaterialApp(
        title: 'Face',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //home: CnpjHomeScreen(),
        routes: {
          AppRoutes.ASK_CNPJ_SCREEN: (ctx) => AskCnpjScreen(),
          AppRoutes.CNPJ_HOME_SCREEN: (ctx) => CnpjHomeScreen(),
          AppRoutes.COLABS_SCREEN: (ctx) => ColabsScreen(),
          AppRoutes.COLAB_REG_SCREEN: (ctx) => FormScreen(),
          //AppRoutes.COLABS_REG_SCREEN: (ctx) => ColabsScreen(),
        },
      ),
    );
  }
}

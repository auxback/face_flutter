// A screen that allows users to take a picture using a given camera.
import 'package:camera/camera.dart';
import 'package:face_teste/provider/providerCamera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// No momento, não estou usando esse, mas sim "exemplo.dartq"

class TakePictureScreen2 extends StatefulWidget {
  const TakePictureScreen2({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  TakePictureScreen2State createState() => TakePictureScreen2State();
}

class TakePictureScreen2State extends State<TakePictureScreen2> {
  late ProviderCamera camProvider = Provider.of<ProviderCamera>(context);
  late CameraController _controller = camProvider.controller;
  late Future<void> _initializeControllerFuture =
      Provider.of<ProviderCamera>(context).initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    camProvider.inicializaCamera();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();

    // Next, initialize the controller. This returns a Future.
  }

  // talvez aqui feche o app da câmera
  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fill this out in the next steps.
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the preview.
          return CameraPreview(_controller);
        } else {
          // Otherwise, display a loading indicator.
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

import 'package:face_teste/provider/owner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColabsScreen extends StatefulWidget {
  ColabsScreen();

  @override
  _ColabsScreenState createState() => _ColabsScreenState();
}

class _ColabsScreenState extends State<ColabsScreen> {
  late OwnerProvider ownerProv = Provider.of(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('colaboradores'),
      ),
      body: ListView.builder(
          itemCount: ownerProv.colabs.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(ownerProv.colabs[index].toString()),
              //executa o método em cada ítem retornando
              //leading: CircleAvatar(backgroundImage: ,),
            );
          }),
    );
  }
}

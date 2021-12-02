import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:face_teste/models/colab.dart';
import 'package:face_teste/provider/owner.dart';
import 'package:face_teste/widgets/exemplo.dart';
import 'package:face_teste/provider/providerCamera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Há 2 formas de passar o Product: null ou por "arguments"

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  //----------------------//----------------------//----------------------//----

  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();

//
  late ProviderCamera camProvider =
      Provider.of<ProviderCamera>(context, listen: false);
  late CameraDescription camera = camProvider.firstCamera;

  late OwnerProvider ownerProvider = Provider.of(context, listen: false);

  bool permiteFoto = false;

  late File image;

  final _imageUrlController = TextEditingController();

  final _formGK = GlobalKey<FormState>();

  // provavelmente "_formData" sempre vai começar vazio
  // "dynamic" antes era "object", mas tava dando erro em "initialValue" em "TextFormField".
  final _formData = Map<String, dynamic>();

  bool _isLoading = false;

  //----------------------//----------------------//----------------------//----
  @override
  void initState() {
    print('initState');
    super.initState();
    //_imageUrlFocus.addListener(_updateImage);
  }

  //----------------------//----------------------//----------------------//----
  // Ainda não entendo bem o "didChangeDependencies"
  // provavelmente é executado quando entra no widget
  // é aqui que vou colocar as infos de "Assunto"
  @override
  void didChangeDependencies() {
    print('didChange');
    super.didChangeDependencies();
    /*
    if (_formData.isEmpty) {
      //aqui passa por argumento os dados do objeto
      //nesse caso eu passaria o colab
      final product = ModalRoute.of(context)!.settings.arguments as Product;

      //se o objeto (q vem de argumento) tem alguma info ai preenche "_formData" com os argumentos do objeto
      if (product != null) {
        _formData['id'] = product.id;
        _formData['title'] = product.title;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;

        // POR QUE COLOCA AQUI, E NÃO NO INITIAL ?!
        _imageUrlController.text = _formData['imageUrl'];
      } else {
        //se "_formData" começa sem info, como que é feito isto ?
        // precise ser por aqui, pois pode entrar com valor ou não
        _formData['price'] = '';
      }
    }
    */
  }

  //----------------------//----------------------//----------------------//----
  void _updateImage() {
    setState(() {});
  }

  //----------------------//----------------------//----------------------//----
  // momento em q todas as etapas são salvas, onde é feito no ultimo textFormField
  Future<void> _saveForm() async {
    //aqui verifica se as informações estão corretas (sem erro e etc)
    bool isValid = _formGK.currentState!.validate();

    //sai do método caso n esteja válido
    if (!isValid) return;

    //salva as infos que foram alteradas no formulario
    _formGK.currentState!.save();

    image = File(camProvider.imagePath);

    // preciso deixar essa criação dentro do try
    /*
    final colab = Colab(
      //id seria o do servidor
      id: _formData['id'],
      name: _formData['name'],
      image: image,
    );
*/
    setState(() {
      _isLoading = true;
    });

    //final products = Provider.of<Products>(context, listen: false);

    try {
      //quando entrar no formulário
      // ve se o produto tem id (não existe ainda)
      if (_formData['id'] == null) {
        // add colab com nome em String. A imagem no tipo "File" é convertido p/ b64 em "ownerProvider.addColab()"
        await ownerProvider.addColab(
            _formData['name'], File(camProvider.imagePath));
      } else {
        //  caso exista (tenha "id")
        //await products.updateColab(colab);
      }
      // retorna pra tela anterior, finalizando o form
      Navigator.of(context).pop();
      //avalia erros
      //------------------------------------------------------------------------
    } catch (error) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro interno'),
          // Poderia usar error de catchError aqui se quisesse.
          content: Text('Aperte "OK" para enviar o erro para tratamento'),
          actions: [
            TextButton(
              onPressed: () {
                _isLoading = false;
                // todo pop é passado para o próximo then ou catchError
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            )
          ],
        ),
      );
    } finally {
      setState(
        () {
          _isLoading = false;
        },
      );
    }
    //--------------------------------------------------------------------------
  }

  //----------------------//----------------------//----------------------//----
  // O dispose só é chamado quando o widget precisa ser reconstruído.
  @override
  void dispose() {
    print('dispose');
    super.dispose();
    //_priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.removeListener(_updateImage);
    _imageUrlFocus.dispose();
    // talvez n seja aqui, mas é um teste
    //permiteFoto = false;
  }

  //----------------------//----------------------//----------------------//----

  @override
  Widget build(BuildContext context) {
    //print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro do Colaborador'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          ),
        ],
      ),
      // _isLoading começa "false"
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              //chave global...
              key: _formGK,
              child: ListView(
                padding: EdgeInsets.all(15.0),
                children: [
                  // bom lembrar que o "focus" depende do logo abaixo
                  TextFormField(
                    //valor inicial, no caso do objeto já existir
                    initialValue: _formData['name'],
                    decoration: InputDecoration(labelText: 'nome'),
                    // vai pra próximo elemento, mas precisa do "foco"
                    textInputAction: TextInputAction.next,
                    /*onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_priceFocus),
                    */
                    onSaved: (value) => _formData['name'] = value,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Informe um nome';
                      }

                      if (value.trim().length < 2) {
                        return 'Mínimo de 2 letras';
                      }
                      return null;
                    },
                  ),
                  /*
                  TextFormField(
                    initialValue: _formData['price'].toString(),
                    decoration: InputDecoration(labelText: 'Preço'),
                    keyboardType: TextInputType.numberWithOptions(
                        decimal:
                            true), // permite usar teclado numérico com vírgula
                    textInputAction: TextInputAction.next,
                    focusNode: _priceFocus,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_descriptionFocus),
                    onSaved: (value) =>
                        _formData['price'] = double.parse(value!),
                    validator: (value) {
                      bool isEmpty = value!.trim().isEmpty;
                      var newPrice = double.tryParse(value);
                      bool isInvalid = newPrice == null || newPrice <= 0;

                      if (isEmpty || isInvalid)
                        return 'Informe um valor maior que zero';

                      return null;
                    },
                  ),
                  // no momento n preciso de descrição
                  TextFormField(
                    initialValue: _formData['description'],
                    decoration: InputDecoration(labelText: 'Descrição'),
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    maxLength: 1000,
                    //textInputAction: TextInputAction.next,  // Pode atrapalhar caso queira só passar para prox linha
                    focusNode: _descriptionFocus,
                    onSaved: (value) => _formData['description'] = value,
                    validator: (value) {
                      /*
                      // Aqui é o momento que todo o formulário é salvo
                            _saveForm();
                      */
                      // tem q ver se o "!" vai funcionar bem
                      bool isEmpty = value!.trim().isEmpty;
                      bool isInvalid = value.trim().length < 10;

                      if (isEmpty || isInvalid)
                        return 'Informe uma descrição. Mínimo 10 caracteres';
                      return null;
                    },
                  ),
                  */
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      //print(camera);
                      //  claro, antes de ir pra camera é preciso inicializá-la
                      await camProvider.inicializaCamera();
                      //  o abaixo precisa vir pelo provider
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) =>
                                      TakePictureScreen(camera: camera)))
                          .then((value) {
                        if (value = true) {
                          permiteFoto = true;
                          setState(() {});
                        }
                        // preciso colocar uma exceção pra quando a foto já existir e ent pegar pelo servidor
                      });
                    },
                    child: Text('tirar foto'),
                  ),
                  //------------------------------------------------------------
                  permiteFoto
                      ? DisplayPictureScreen(imagePath: camProvider.imagePath)
                      : Spacer(),
                  //------------------------------------------------------------
                  //
                  // onde o formulário é salvo
                  ElevatedButton(
                    onPressed: () {
                      _saveForm();
                    },
                    child: Text('cadastrar'),
                  ),
                  //
                  // a parte seguinte comentada pode ser util p/ "focus" e o "saveForm"
                  /*
                  // parte relacionada 
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration:
                              InputDecoration(labelText: 'URL da imagem'),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          focusNode: _imageUrlFocus,
                          controller: _imageUrlController,
                          onFieldSubmitted: (_) {
                            //Aqui é o momento que todo o formulário é salvo
                            _saveForm();
                          },
                          onSaved: (value) => _formData['imageUrl'] = value,
                          validator: (value) {
                            bool isEmpty = value!.trim().isEmpty;
                            bool validUrl = _isValidImageUrl(value);

                            if (isEmpty || validUrl)
                              return 'Informe uma URL válida';

                            return null;
                          },
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        margin: EdgeInsets.only(
                          top: 8,
                          left: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: _imageUrlController.text.isEmpty
                            ? Text('informe a URL')
                            : FittedBox(
                                child: Image.network(
                                  _imageUrlController.text,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ],
                  ),*/
                ],
              ),
            ),
    );
  }
}

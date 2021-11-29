import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:shop/providers/product.dart';
//import 'package:shop/providers/products.dart';

// Há 2 formas de passar o Product: null ou por arguments

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  //----------------------//----------------------//----------------------//----
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();

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
    _imageUrlFocus.addListener(_updateImage);
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
    bool isValid = _formGK.currentState!.validate();

    //sai do método caso n esteja válido
    if (!isValid) return;

    //salva as infos que foram alteradas no formulario
    _formGK.currentState!.save();

    //att as infos ou criando uma nova
    /*
    final product = Product(
      id: _formData['id'],
      title: _formData['title'],
      description: _formData['description'],
      price: _formData['price'],
      imageUrl: _formData['imageUrl'],
    );
    */

    setState(() {
      _isLoading = true;
    });

    //final products = Provider.of<Products>(context, listen: false);

    try {
      // ve se o produto tem id (não existe ainda)
      if (_formData['id'] == null) {
        //  adiciona um novo produto com id do servidor
        //await products.addProduct(product);
      } else {
        //  só atualiza caso tenha o id
        //await products.updateProduct(product);
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
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.removeListener(_updateImage);
    _imageUrlFocus.dispose();
  }

  //----------------------//----------------------//----------------------//----

  @override
  Widget build(BuildContext context) {
    //print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Produto'),
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
                  TextFormField(
                    //valor inicial, no caso do objeto já existir
                    initialValue: _formData['title'],
                    decoration: InputDecoration(labelText: 'Título'),
                    // vai pra próximo elemento, mas precisa do "foco"
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_priceFocus),
                    onSaved: (value) => _formData['title'] = value,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Informe um título';
                      }

                      if (value.trim().length < 2) {
                        return 'Mínimo de 2 letras';
                      }
                      return null;
                    },
                  ),
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
                  SizedBox(
                    height: 5,
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

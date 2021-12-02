- fazer widget do formulario
deu um erro na hora q fui exibir o widget do formulário.

- em "exemplo.dart" preciso adicionar teste de print entre as linhas 85+/- pra ver se tá funcionando, principalmente
a parte q o Provider.imagePath tá sendo igual a tal coisa.
- tive problemas com "Provider.of(context)". Precisei colocar ",listen: false" em todos parecidos
- resolvido a questão de fazer a foto aparecer depois q voltar p tela anterior, introduzindo um setState() no local onde permiteFoto é vdd.

-> agr preciso fazer os métodos de add colab e enviar pra uma lista. no formulario tlvz seja interessante verificar se se tem foto (!= null) e
tmbm no "nome" talvez.

- no momento, agora fazendo o listTile de "colabs_screen.dart", mas preciso entender como trabalhar com imagens dentro do Dart, pois File só corresponde ao caminho do arqui e quando passando p/ base64 vira uma string. Então, como usar uma imagem no flutter passando de b64 (linha 41 e 44 em "owner.dart").
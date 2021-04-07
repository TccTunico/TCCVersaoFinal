import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tunico/controllers/criar_conta_controller.dart';
import 'package:tunico/views/components/FlatButtonExt/index.dart';
import 'package:tunico/views/components/TextFormFieldExt/index.dart';
import 'package:tunico/views/components/foto_convert.dart';

class CriarConta extends StatefulWidget {
  @override
  _CriarContaState createState() => _CriarContaState();
}

class _CriarContaState extends State<CriarConta> {

  final _formKey = GlobalKey<FormState>();
  final imagePicker = ImagePicker();
  final _controller = CriarContaController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color:Color.fromRGBO(255, 107,107, 1)),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        title: Text('Criar Conta', style: TextStyle(color: Colors.grey[800]),), 
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                          width: 200,
                          height: 200,
                          child: ClipOval(
                            child: FotoConvert().retornaFoto(_controller.fotoController.text),
                          ),
                      ),
                    ),
                    Center(
                      child: Container(
                        color: Colors.transparent,
                        width: 250,
                        height: 190,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: PopupMenuButton<int>(
                            itemBuilder: (context) => <PopupMenuEntry<int>>[
                              const PopupMenuItem<int>(
                                child: Text('Câmera'),
                                value: 0,
                              ),
                              const PopupMenuItem<int>(
                                child: Text('Galeria'),
                                value: 1,
                              )
                            ],
                            onSelected: (valor) async {
                              final fotoSelecionada =
                                  await imagePicker.getImage(
                                      source: (valor == 0
                                          ? ImageSource.camera
                                          : ImageSource.gallery));
                              setState(() {
                                if(fotoSelecionada == null) return;
                                _controller.fotoController.text = fotoSelecionada.path;
                              });
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 20, 50, 0),
                child: TextFormFieldExt(
                  labelText: 'Nome',
                  maxLenght: 30,
                  keyboardType: TextInputType.name,
                  prefixIcon: Icon(Icons.edit, color:Color.fromRGBO(255, 148, 88, 1),),
                  controller: _controller.nomeController,
                  validator: (text) {
                    if (text.trim().length == 0)
                      return 'Nome não informado';
                  }),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 5, 50, 0),
                child: TextFormFieldExt(
                  labelText: 'E-mail',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(Icons.email, color: Color.fromRGBO(255, 148, 88, 1),),
                  controller: _controller.emailController,
                  validator: (text) {
                    if (text.trim().length == 0)
                      return 'E-mail não informado';
                  }),
              ),
               Padding(
                padding: EdgeInsets.fromLTRB(50, 5, 50, 0),
                child: TextFormFieldExt(
                  labelText: 'Senha',
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  maxLines: 1,
                  prefixIcon: Icon(Icons.vpn_key, color: Color.fromRGBO(255, 148, 88, 1),),
                  controller: _controller.senhaController,
                  validator: (text) {
                    if (text.trim().length < 6)
                      return 'A senha precisa ter no mímino 6 caracteres';
                  }),
              ),
              
              Padding(
                padding: EdgeInsets.fromLTRB(50, 30, 50, 0),
                child: FlatButtonExt(
                  text: 'Cadastrar',
                  onPressed: () {
                    if (!_formKey.currentState.validate()) return;
                    _controller.criarConta(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
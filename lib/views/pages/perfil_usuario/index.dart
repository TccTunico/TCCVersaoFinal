import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tunico/controllers/perfil_controller.dart';
import 'package:tunico/views/components/FlatButtonExt/index.dart';
import 'package:tunico/views/components/NavigationBarExt/index.dart';
import 'package:tunico/views/components/TextFormFieldExt/index.dart';
import 'package:tunico/views/components/foto_convert.dart';

class PerfilUsuario extends StatefulWidget {
  @override
  _PerfilUsuarioState createState() => _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<PerfilUsuario> {
  final _formKey = GlobalKey<FormState>();
  final imagePicker = ImagePicker();
  final _controller = PerfilController();

  bool consertarProblema = true;

  Future <String> createAlertDialog(BuildContext context){
     TextEditingController customController =  TextEditingController();
      return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(29.5, 0, 29.5, 0),
          child: Text('Insira a sua senha', style: TextStyle(fontSize: 18),),
        ),
      
        content: 
        TextField(
          controller: customController,
          decoration: InputDecoration(
            labelText: 'Senha',
            icon: Icon(Icons.vpn_key, color:  Color.fromRGBO(255, 148, 88, 1),),
          ),
          keyboardType: TextInputType.text,
          obscureText: true,
        ),
        actions: <Widget> [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 60, 0),
            child: MaterialButton(
              elevation: 0.0,
              child: Text('CANCELAR'),
              onPressed: (){
                Navigator.pop(context);
              },
              color: Colors.grey[200],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: MaterialButton(
              elevation: 5.0,
              child: Text('OK'),
              onPressed: (){
                _controller.apagarUsuario(context, customController.text);
              },
              color: Color.fromRGBO(255, 107,107, 1),
            ),
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if(consertarProblema){
      _controller.loadUserData(context).then((value) {
        setState(() {});
        consertarProblema = false;
      });
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Perfil', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () {
              _controller.sair(context);
            }
          ),
        ],
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
                        )
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
                                if (fotoSelecionada == null) return;
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
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: TextFormFieldExt(
                  labelText: 'Nome',
                  maxLenght: 30,
                  keyboardType: TextInputType.name,
                  prefixIcon: Icon(Icons.edit, color:Color.fromRGBO(255, 148, 88, 1),),
                  controller: _controller.nomeController,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: TextFormFieldExt(
                  labelText: 'Instituição',
                  maxLenght: 50,
                  keyboardType: TextInputType.text,
                  prefixIcon: Icon(Icons.school, color: Color.fromRGBO(255, 148, 88, 1),),
                  controller: _controller.instituicaoController,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: TextFormFieldExt(
                  labelText: 'Curso',
                  maxLenght: 50,
                  keyboardType: TextInputType.text,
                  prefixIcon: Icon(Icons.book, color: Color.fromRGBO(255, 148, 88, 1),),
                  controller: _controller.cursoController,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: TextFormFieldExt(
                  labelText: 'Número de Telefone',
                  maxLenght: 15,
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icon(Icons.call, color: Color.fromRGBO(255, 148, 88, 1),),
                  controller: _controller.telefoneController,
              ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 30, 50, 0),
                child: FlatButtonExt(
                  text: 'Salvar',
                  onPressed: () {
                    _controller.salvar(context);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 10, 50, 0),
                child: FlatButtonExt(
                  text: 'Apagar Conta',
                  onPressed: () {
                    createAlertDialog(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBarExt(paginaAtual: 'perfil'),
    );
  }
}
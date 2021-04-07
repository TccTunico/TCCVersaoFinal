import 'package:flutter/cupertino.dart';
import 'package:tunico/data/models/usuario_model.dart';
import 'package:tunico/data/repositories/usuario_repository.dart';
import 'package:tunico/routes/app_routes.dart';
import 'package:tunico/views/components/FlushbarExt/index.dart';

class CriarContaController{
  final _usuarioRepository = UsuarioRepository();
  
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final fotoController = TextEditingController();

  bool controlarProblema = true;

  void criarConta(BuildContext context) async {
    var usuario = new UsuarioModel(
      nome: nomeController.text, 
      email: emailController.text.trim(),
      foto: fotoController.text,
    );
    try{
      if(controlarProblema){
        controlarProblema = false;
        await _usuarioRepository.incluir(usuario, senhaController.text); 
        Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.HOME, (route) => false);
        controlarProblema = true;
      }
    }
    catch (ex) {
      controlarProblema = true;
      print('******* ERRO *******');
      print(ex.toString());
      String erro = FlushbarExt().erro(ex.toString());
      FlushbarExt().mostrarErro(context, erro);
    }
  }
}
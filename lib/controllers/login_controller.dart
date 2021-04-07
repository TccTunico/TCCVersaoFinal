import 'package:flutter/material.dart';
import 'package:tunico/data/repositories/login_repository.dart';
import 'package:tunico/routes/app_routes.dart';
import 'package:tunico/views/components/FlushbarExt/index.dart';

class LoginController{
  final _repository = LoginRepository();

  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  void entrar(BuildContext context) async{
    try{
      await _repository.efetuarLogin(emailController.text, senhaController.text);
      Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
    }
    catch (ex) {
      print('******* ERRO *******');
      print(ex.toString());
      String erro = FlushbarExt().erro(ex.toString());
      FlushbarExt().mostrarErro(context, erro);
    }
  }
  void recuperarSenha(BuildContext context) async {
    try{
      _repository.recuperarSenha(emailController.text);
      FlushbarExt().mostrarErro(context, 'Um e-mail foi enviado para alteração da senha');
    }
    catch (ex) {
      print('******* ERRO *******');
      print(ex.toString());
      String erro = FlushbarExt().erro(ex.toString());
      FlushbarExt().mostrarErro(context, erro);
    }
  }
  void criarConta(BuildContext context) async{
    Navigator.of(context).pushNamed(AppRoutes.CRIAR_CONTA);
  }
}
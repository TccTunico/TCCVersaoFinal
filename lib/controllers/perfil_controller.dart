import 'package:flutter/cupertino.dart';
import 'package:tunico/data/models/usuario_model.dart';
import 'package:tunico/data/providers/fire_base_auth_provider.dart';
import 'package:tunico/data/repositories/usuario_repository.dart';
import 'package:tunico/routes/app_routes.dart';
import 'package:tunico/views/components/FlushbarExt/index.dart';
import 'package:tunico/views/components/foto_convert.dart';

class PerfilController {
  final _repository = new UsuarioRepository();
  final _auth = new FireBaseAuthProvider();

  String email;
  List agendas;
  dynamic image;
  final nomeController = new TextEditingController();
  final fotoController = new TextEditingController();
  final cursoController = new TextEditingController();
  final instituicaoController = new TextEditingController();
  final telefoneController = new TextEditingController();

  UsuarioModel userData;
  String fotoAntiga;

  Future<void> loadUserData(BuildContext context) async {
    try{
      userData = await _repository.getUserData();
      fotoController.text = userData.foto;
      fotoAntiga = userData.foto;
      nomeController.text = userData.nome;
      cursoController.text = userData.curso;
      instituicaoController.text = userData.instituicao;
      telefoneController.text = userData.telefone;
      email = userData.email;
      agendas = userData.agendas;
      image = FotoConvert().retornaFoto(fotoController.text);
    }
    catch (ex) {
      print('******* ERRO *******');
      print(ex.toString());
      String erro = FlushbarExt().erro(ex.toString());
      FlushbarExt().mostrarErro(context, erro);      
    }
  }

  void salvar(BuildContext context) async {

    var usuario = new UsuarioModel(
      email: email,
      agendas: agendas,
      foto: fotoController.text,
      nome: nomeController.text,
      curso: cursoController.text,
      instituicao: instituicaoController.text,
      telefone: telefoneController.text,
    );
    if (usuario.foto == fotoAntiga) fotoAntiga = "";
    try{
      await _repository.alterar(usuario, fotoAntiga);
      fotoAntiga = usuario.foto;
      FlushbarExt().mostrarErro(context, 'Dados salvos');
    }
    catch (ex){
      print('******* ERRO *******');
      print(ex.toString());
      String erro = FlushbarExt().erro(ex.toString());
      FlushbarExt().mostrarErro(context, erro);
    }
      
  }

  Future<void> apagarUsuario(BuildContext context, String senha) async {
    try{
      await _repository.excluir(fotoController.text, senha);
      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.LOGIN, (route) => false);
    }
    catch (ex) {
      print('******* ERRO *******');
      print(ex.toString());
      String erro = FlushbarExt().erro(ex.toString());
      FlushbarExt().mostrarErro(context, erro);
    }
  }

  void sair(BuildContext context){
    try{
      _auth.efetuarLogoff();
      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.LOGIN, (route) => false);
    }
    catch (ex) {
      print('******* ERRO *******');
      print(ex.toString());
      String erro = FlushbarExt().erro(ex.toString());
      FlushbarExt().mostrarErro(context, erro);
    }
  }
}
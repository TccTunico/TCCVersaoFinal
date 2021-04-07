import 'package:flutter/material.dart';
import 'package:tunico/data/models/post_model.dart';
import 'package:tunico/data/models/usuario_model.dart';
import 'package:tunico/data/repositories/post_repository.dart';
import 'package:tunico/data/repositories/usuario_repository.dart';
import 'package:tunico/views/components/FlushbarExt/index.dart';

class AgendaPageController{
  final _postRepository = PostRepository();
  final _usuarioRepository = UsuarioRepository();
  List<PostModel> posts = new List<PostModel>();
  List<UsuarioModel> usuarios = new List<UsuarioModel>();

  Future<void> atualizarPosts(BuildContext context, String idAgenda) async {
    try{
      posts = await _postRepository.listarAgendas(idAgenda);
      for(var index = 0; index < posts.length; index++){
        var user = await _usuarioRepository.getUserData(userId: posts[index].idUser);
        usuarios.insert(index, user);
      }
    }
    catch (ex) {
      print('******* ERRO *******');
      print(ex.toString());
      String erro = FlushbarExt().erro(ex.toString());
      FlushbarExt().mostrarErro(context, erro);
    }
  }
}
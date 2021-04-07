import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tunico/data/models/post_model.dart';
import 'package:tunico/data/repositories/post_repository.dart';
import 'package:tunico/views/components/FlushbarExt/index.dart';

class CriarPostController{
  final _postRepository = PostRepository();
  final textoController = TextEditingController();
  String filePath;
  bool controlarProblema = true;

  void fazerPostagem(BuildContext context, String idAgenda) async {
    var post = new PostModel(
      idAgenda: idAgenda,
      data: Timestamp.now(),
      pdfFilePath: filePath,
      texto: textoController.text
    );
    try{
      if (!controlarProblema) return;
      controlarProblema = false;
      await _postRepository.incluir(post);
      Navigator.pop(context);
    }catch (ex) {
      print('******* ERRO *******');
      print(ex.toString());
      String erro = FlushbarExt().erro(ex.toString());
      FlushbarExt().mostrarErro(context, erro);
    }
  }
}
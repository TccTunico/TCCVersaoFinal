import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tunico/data/models/agenda_model.dart';
import 'package:tunico/data/repositories/agenda_repository.dart';
import 'package:tunico/routes/app_routes.dart';
import 'package:tunico/views/components/FlushbarExt/index.dart';

class CriarAgendaController {
  final _agendaRepository = AgendaRepository();
  
  final nomeController = TextEditingController();
  final descricaoController = TextEditingController();
  final senhaController = TextEditingController();
  final fotoController = TextEditingController();

  bool controlarProblema = true;

  void criarAgenda(BuildContext context, {DateTime validade}) async {
    var agenda = new AgendaModel(
      nome: nomeController.text, 
      descricao: descricaoController.text,
      foto: fotoController.text,
      senha: senhaController.text,
    );
    if (validade != null)
      agenda.validade = new Timestamp.fromDate(validade);
    try{
      if (validade != null && DateTime.now().difference(validade).inMilliseconds > 0){
        FlushbarExt().mostrarErro(context, 'Coloque uma data futura a atual');
        return;
      }
      if(controlarProblema){
        controlarProblema = false;
        await _agendaRepository.incluir(agenda);
        Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
        controlarProblema = true;
      }
      else print('Impossibilitado de criar novamente');
    }
    catch (ex) {
      print('******* ERRO *******');
      print(ex.toString());
      String erro = FlushbarExt().erro(ex.toString());
      FlushbarExt().mostrarErro(context, erro);
    }
  }
}
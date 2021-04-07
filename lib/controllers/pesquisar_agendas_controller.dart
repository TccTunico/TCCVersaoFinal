import 'package:flutter/cupertino.dart';
import 'package:tunico/data/models/agenda_model.dart';
import 'package:tunico/data/repositories/agenda_repository.dart';
import 'package:tunico/views/components/FlushbarExt/index.dart';

class PesquisarController{
  final _agendaRepository = new AgendaRepository();
  final pesquisaController = TextEditingController();

  List<AgendaModel> agendas = new List<AgendaModel>();

  Future<void> atualizarItens(BuildContext context) async {
    try{
      agendas = await _agendaRepository.listarAgendas(pesquisaController.text, false);
    }
    catch (ex) {
      print('******* ERRO *******');
      print(ex.toString());
      String erro = FlushbarExt().erro(ex.toString());
      FlushbarExt().mostrarErro(context, erro);
    }
  }
}
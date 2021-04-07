import 'package:flutter/cupertino.dart';
import 'package:tunico/data/repositories/agenda_repository.dart';
import 'package:tunico/routes/app_routes.dart';
import 'package:tunico/views/components/FlushbarExt/index.dart';

class IngressarAgendaController {
  final _agendaRepository = AgendaRepository();
  final senhaController = TextEditingController();

  void ingressar(BuildContext context, String idAgenda) async {
    try{
      bool senhaValida = await _agendaRepository.ingressar(idAgenda, senhaController.text);
      if (senhaValida)
        Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.HOME, (route) => false);
      else
        FlushbarExt().mostrarErro(context, 'Senha inválida');
    }
    catch (ex) {
      print('******* ERRO *******');
      print(ex.toString());
      String erro = FlushbarExt().erro(ex.toString());
      FlushbarExt().mostrarErro(context, erro);
    }
  }
}
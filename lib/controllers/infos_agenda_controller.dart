import 'package:flutter/material.dart';
import 'package:tunico/data/models/usuario_model.dart';
import 'package:tunico/data/repositories/agenda_repository.dart';
import 'package:tunico/data/repositories/usuario_repository.dart';
import 'package:tunico/routes/app_routes.dart';
import 'package:tunico/views/components/FlushbarExt/index.dart';

class InfosAgendaController {
  final _agendaRepository = AgendaRepository();
  final _usuarioRepository = UsuarioRepository();
  List<UsuarioModel> participantes = new List<UsuarioModel>();

  Future<void> listarParticipantes(BuildContext context, String idAgenda) async {
    try{
      participantes = await _agendaRepository.listarParticipantes(idAgenda);
    }
    catch (ex) {
      print('******* ERRO *******');
      print(ex.toString());
      String erro = FlushbarExt().erro(ex.toString());
      FlushbarExt().mostrarErro(context, erro);
    }
  }

  Future<void> sairAgenda(BuildContext context, String idAgenda) async {
    try{
      await _usuarioRepository.sairAgenda(idAgenda);
      await _agendaRepository.listarParticipantes(idAgenda).then(
        (listaParti) async {
          if (listaParti.length == 0)
            await _agendaRepository.excluir(idAgenda);
        }
      );
      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.HOME, (route) => false);
    }
    catch (ex) {
      print('******* ERRO *******');
      print(ex.toString());
      String erro = FlushbarExt().erro(ex.toString());
      FlushbarExt().mostrarErro(context, erro);
    }
  }
}
import 'package:tunico/views/pages/criar_agenda/index.dart';
import 'package:tunico/views/pages/criar_conta/index.dart';
import 'package:tunico/views/pages/home/index.dart';
import 'package:tunico/views/pages/login/index.dart';
import 'package:tunico/views/pages/perfil_usuario/index.dart';
import 'package:tunico/views/pages/pesquisar_agendas/index.dart';

abstract class AppRoutes{
  static const String PERFIL_USUARIO = 'PERFIL_USUARIO';
  static const String CRIAR_CONTA = 'CRIAR_CONTA';
  static const String HOME = 'HOME';
  static const String CRIAR_AGENDA = 'CRIAR_AGENDA';
  static const String LOGIN = 'LOGIN';
  static const String PESQUISAR_AGENDAS = 'PESQUISAR_AGENDAS';

  static final routes = {
    PERFIL_USUARIO: (context) => PerfilUsuario(),
    CRIAR_CONTA: (context) => CriarConta(),
    HOME: (context) => HomePage(),
    CRIAR_AGENDA: (context) => CriarAgendaPage(),
    LOGIN: (context) => TelaInicial(),
    PESQUISAR_AGENDAS: (context) => PesquisarAgendasPage(),
  };
}
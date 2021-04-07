import 'package:tunico/data/models/agenda_model.dart';
import 'package:tunico/data/models/usuario_model.dart';
import 'package:tunico/data/providers/agenda_provider.dart';
import 'package:tunico/data/providers/cloud_firestore_provider.dart';
import 'package:tunico/data/providers/fire_base_auth_provider.dart';
import 'package:tunico/data/repositories/usuario_repository.dart';

class AgendaRepository {
  final _provider = AgendaProvider();
  final _usuarioRepository = UsuarioRepository();
  final _cfsp = new CloudFireStoreProvider();
  final _auth = new FireBaseAuthProvider();

  Future<bool> incluir(AgendaModel agenda) async {
    String currentUserId = _auth.getUserAuthData()['id'];

    if (agenda.foto != null && !agenda.foto.contains('http') && agenda.foto != "")
      agenda.foto = await _cfsp.uploadFile(agenda.foto, Categoria().agenda);
    agenda.participantes = [currentUserId];

    String idAgenda = await _provider.incluir(agenda.toMap());
    if (idAgenda == null)
      return false;
    
    _usuarioRepository.adicionarAgenda(idAgenda);
    return true;
  }

  Future<void> alterar(AgendaModel agenda) async {
    await _provider.alterar(agenda.toMap());
  }

  Future<void> excluir(String idAgenda) async {
    await _provider.excluir(idAgenda);
  }

  Future<List<AgendaModel>> listarAgendas(String pesquisa, bool userAgendas) async {
    await _provider.verificarValidade();
    UsuarioModel userData = await _usuarioRepository.getUserData();
    var listMap;
    if (userData == null) return null;
    if (userAgendas)
      listMap = await _provider.userAgendas(userData.agendas, pesquisa);
    else
      listMap = await _provider.procurarAgendas(userData.agendas, pesquisa);

    if(listMap == null) return null;

    var lista = List<AgendaModel>();

    for (var agenda in listMap) {
      lista.add(AgendaModel.fromMap(agenda));
    }

    return lista;
  }

  Future<bool> ingressar(String idAgenda, String senha) async {
    //get user id
    String currentUserId = _auth.getUserAuthData()['id'];
    //verifica se 
    bool senhaValida = await _provider.adicionarParticipante(idAgenda, currentUserId, senha);

    if(senhaValida)
      await _usuarioRepository.adicionarAgenda(idAgenda);
    
    return senhaValida;
  }

  Future<void> retirarParticipante(String idAgenda, String idUser) async {
    await _provider.retirarParticipante(idAgenda, idUser);
  }

  Future<List<UsuarioModel>> listarParticipantes(String idAgenda) async{
    List participantes = await _provider.listarParticipantes(idAgenda);
    List<UsuarioModel> dadosParti = [];
    for(var part in participantes){
      var dadosPart = await _usuarioRepository.getUserData(userId: part);
      dadosParti.add(dadosPart);
    }
    return dadosParti;
  }

}
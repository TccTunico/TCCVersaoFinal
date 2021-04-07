import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tunico/data/providers/cloud_firestore_provider.dart';
import 'package:tunico/data/providers/post_provider.dart';

class AgendaProvider{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final _cfsp = new CloudFireStoreProvider();
  static final _postProvider = PostProvider();

  //Incluir
  Future<String> incluir(Map map) async {
    String id;
    await _firestore.collection('agendas').add(map).then((docRef) => {id = docRef.id});
    return id;
  }

  //Excluir
  Future<void> excluir(String id) async {
    //apaga da o id da agenda da lista de agendas de cada usuario que pertence à agenda
    await _firestore.collection('usuarios').where('agendas', arrayContains: id).get().then(
      (qs) async {
        for (var user in qs.docs)
          await _firestore.collection('usuarios').doc(user.id)
            .update({'agendas': FieldValue.arrayRemove([id])});
      }
    );
    // apagar posts
    await _postProvider.excluir(idAgenda: id);
    //apaga a foto (se tiver)
    await _firestore.collection('agendas').doc(id).get().then(
      (agenda) async {
        if(agenda.data()['foto'] != null && agenda.data()['foto'] != '')
          await _cfsp.apagarArquivo(agenda.data()['foto']);
      }
    );
    //apaga a agenda do banco de dados
    await _firestore.collection('agendas').doc(id).delete();
  }

  //Listar as agendas que o usuario pertence
  Future<List<Map>> userAgendas(List userAgendas, String pesquisa) async {
    var listaAgendas = List<Map>();

    if (userAgendas == null || userAgendas == []) return null;

    for (int i = 0; i < userAgendas.length; i++){
      var ds = await _firestore.collection('agendas').doc(userAgendas[i]).get();
      var agenda = ds.data();
      if (pesquisa == null || pesquisa == ''){
        agenda['id'] = userAgendas[i];
        listaAgendas.add(agenda);
      }
      else if (ds.data()['nome'].toLowerCase().contains(pesquisa.toLowerCase())){
        agenda['id'] = userAgendas[i];
        listaAgendas.add(agenda);
      }
    }

    return listaAgendas;
  }

  //Listar as agendas que o usuario não está incluido
  Future<List<Map>> procurarAgendas(List userAgendas, String pesquisa) async{
    var listaAgendas = List<Map>();

    if(userAgendas != null && userAgendas.length == 0) userAgendas = null;

    var qs = await _firestore.collection('agendas').where(FieldPath.documentId, whereNotIn: userAgendas).get();
    for (int i = 0; i < qs.docs.length; i++) {
      var agenda = qs.docs[i].data();
      if (pesquisa == null || pesquisa == ''){
        agenda['id'] = qs.docs[i].id;
        listaAgendas.add(agenda);
      }
      else if (agenda['nome'].toLowerCase().contains(pesquisa.toLowerCase())){
        agenda['id'] = qs.docs[i].id;
        listaAgendas.add(agenda);
      }
    }

    return listaAgendas;
  }

  //Alterar
  Future<void> alterar(Map map) async {
    await _firestore.collection('agendas').doc(map['id']).update(map);
  }

  Future<bool> adicionarParticipante(String idAgenda, String idUser, String senha) async {
    final agenda = await _firestore.collection('agendas').doc(idAgenda).get();

    if(agenda.data()['senha'] == senha){
      await _firestore.collection('agendas')
      .doc(idAgenda)
      .update({
        'participantes': FieldValue.arrayUnion([idUser])
      });
      return true;
    }
    return false;
  }

  Future<void> retirarParticipante(String idAgenda, String idUser) async {
    await _firestore.collection('agendas').doc(idAgenda).update({
      'participantes': FieldValue.arrayRemove([idUser])
    });
  }

  Future<List> listarParticipantes(String idAgenda) async {
    var ds = await _firestore.collection('agendas').doc(idAgenda).get();
    return ds.data()['participantes'];
  }

  Future<void> verificarValidade() async {
    var ds = await _firestore.collection('agendas')
      .where('validade', isLessThan: Timestamp.now())
      .get();
    for(var item in ds.docs)
      await excluir(item.id);
  }
}
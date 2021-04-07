import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tunico/data/providers/cloud_firestore_provider.dart';

class PostProvider{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final _cfsp = CloudFireStoreProvider();

  //Incluir
  Future<void> incluir(Map map) async {
    await _firestore.collection('posts').add(map);
  }

  //Excluir
  Future<void> excluir({String idPost, String idAgenda, String idUser}) async {
    //deleta um único post
    if (idPost != null){
      var ds = await _firestore.collection('posts').doc(idPost).get();
      if (ds.data()['pdfFilePath'] != null && ds.data()['pdfFilePath'] != '')
        await _cfsp.apagarArquivo(ds.data()['pdfFilePath']);
      await _firestore.collection('posts').doc(idPost).delete();
    }
    //deleta todos os posts de uma agenda
    if (idAgenda != null)
      await _firestore.collection('posts').where('idAgenda', isEqualTo: idAgenda).get().then(
        (posts) async {
          for (var post in posts.docs){
            if (post.data()['pdfFilePath'] != null && post.data()['pdfFilePath'] != '')
              await _cfsp.apagarArquivo(post.data()['pdfFilePath']);
            await _firestore.collection('posts').doc(post.id).delete();
          }
        });
    //deleta todos os posts de um usuário
    if (idUser != null)
      await _firestore.collection('posts').where('idUser', isEqualTo: idUser).get().then(
        (posts) async {
          for (var post in posts.docs){
            if (post.data()['pdfFilePath'] != null && post.data()['pdfFilePath'] != '')
              await _cfsp.apagarArquivo(post.data()['pdfFilePath']);
            await _firestore.collection('posts').doc(post.id).delete();
          }
        });
  }

  //Listar as agendas que o usuario pertence
  Future<List<Map>> listarPosts(String idAgenda) async {
    var listaPosts = List<Map>();

    var qs = await _firestore.collection('posts')
      .where('idAgenda', isEqualTo: idAgenda)
      .orderBy('data', descending: true)
      .get();
    for(var post in qs.docs)
      listaPosts.add(post.data());

    return listaPosts;
  }

  //Alterar
  Future<void> alterar(Map map) async {
    await _firestore.collection('posts').doc(map['id']).update(map);
  }
}
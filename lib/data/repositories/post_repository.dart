import 'package:tunico/data/models/post_model.dart';
import 'package:tunico/data/providers/cloud_firestore_provider.dart';
import 'package:tunico/data/providers/fire_base_auth_provider.dart';
import 'package:tunico/data/providers/post_provider.dart';

class PostRepository {
  final _provider = PostProvider();
  final _cfsp = CloudFireStoreProvider();
  final _auth = new FireBaseAuthProvider();

  Future<void> incluir(PostModel post) async {
    String currentUserId = _auth.getUserAuthData()['id'];
    post.idUser = currentUserId;

    if (post.pdfFilePath != null && !post.pdfFilePath.contains('http') && post.pdfFilePath != "")
      post.pdfFilePath = await _cfsp.uploadFile(post.pdfFilePath, Categoria().post);

    await _provider.incluir(post.toMap());
  }

  Future<void> alterar(PostModel post) async {
    await _provider.alterar(post.toMap());
  }

  Future<void> excluir(PostModel post) async {
    //arrumar
    await _provider.excluir(idAgenda: post.idAgenda);
  }

  Future<List<PostModel>> listarAgendas(String idAgenda) async {
    var listMap = await _provider.listarPosts(idAgenda);

    if(listMap == null) return [];

    var lista = List<PostModel>();

    for (var post in listMap) {
      lista.add(PostModel.fromMap(post));
    }

    return lista;
  }
}
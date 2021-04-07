import 'package:flutter/material.dart';
import 'package:tunico/controllers/agenda_page_controller.dart';
import 'package:tunico/data/models/agenda_model.dart';
import 'package:tunico/views/components/card_post/index.dart';
import 'package:tunico/views/components/foto_convert.dart';
import 'package:tunico/views/pages/criar_postagem/index.dart';
import 'package:tunico/views/pages/infos_agenda/index.dart';

class AgendaPage extends StatefulWidget {
  AgendaModel agenda;
  
  AgendaPage(this.agenda);

  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  final _controller = AgendaPageController();

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new InfosAgenda(widget.agenda)
              )
            );
          },
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                child: ClipOval(
                  child: Container(
                    color: Colors.white,
                    child: FotoConvert().retornaFoto(widget.agenda.foto, grupo: true)
                  )
                )
              ),
              SizedBox(width: 15),
              Flexible(
                child: Text(
                  widget.agenda.nome,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: FutureBuilder(
          future: _controller.atualizarPosts(context, widget.agenda.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (_controller.posts.length == 0 || _controller.posts == null)
                return Center(
                  child: Text("Nenhuma postagem"),
                );
              return ListView.builder(
                itemCount: _controller.posts.length,
                itemBuilder: (context, index) {
                  var post = _controller.posts[index];
                  var user = _controller.usuarios[index];
                  return CardPost(
                    userFoto: user == null ? null : user.foto,
                    userNome: user == null ? 'Anônimo' : user.nome,
                    urlPath: post.pdfFilePath,
                    data: post.data.toDate(),
                    texto: post.texto,
                  );
                }
              );
            }
            else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(255, 148, 88, 1)),
                )
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 255, 107, 107),
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new CriarPost(widget.agenda.id)
              )
            ).then((text) {
              setState(() {});
            });
        },
      ),
    );
  }
}

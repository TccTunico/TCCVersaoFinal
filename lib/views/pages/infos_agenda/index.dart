import 'package:flutter/material.dart';
import 'package:tunico/controllers/infos_agenda_controller.dart';
import 'package:tunico/data/models/agenda_model.dart';
import 'package:tunico/views/components/foto_convert.dart';
import 'package:tunico/views/pages/perfil_outros_usuarios/index.dart';

class InfosAgenda  extends StatefulWidget {
  AgendaModel agenda;
  
  InfosAgenda(this.agenda);
  
  @override
  _InfosAgendaState createState() => _InfosAgendaState();
}

class _InfosAgendaState extends State<InfosAgenda > {
  final ScrollController _scrollController = ScrollController();
  final _controller = InfosAgendaController();
  
  Future <String> createAlertDialog(BuildContext context){
      return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(29.5, 0, 29.5, 0),
          child: Text('Atenção!', style: TextStyle(fontSize: 18),),
        ),
      
        content: Text(
          'Deseja realmente sair da agenda?',
          style: TextStyle(
            fontSize: 20,

          ),
        ),
        actions: <Widget> [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 60, 0),
            child: MaterialButton(
              elevation: 0.0,
              child: Text('CANCELAR'),
              onPressed: (){
                Navigator.pop(context);
              },
              color: Colors.grey[200],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: MaterialButton(
              elevation: 5.0,
              child: Text('OK'),
              onPressed: (){
                _controller.sairAgenda(context, widget.agenda.id);
              },
              color: Color.fromRGBO(255, 107,107, 1),
            ),
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        centerTitle: true,
        title: Text('Dados da Agenda', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Form(
          child: ListView(
            children: [

              // IMAGEM AGENDA
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 5,
                          color: Color.fromRGBO(255, 107,107, 1),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(75)
                      )
                    ),
                    child: ClipOval(
                      child: FotoConvert().retornaFoto(widget.agenda.foto, grupo: true)
                    )
                  ),
                ),
              ),
              
              // TÍTULO - NOME AGENDA
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 20, 50, 0),
                child: Center(
                  child: Text(
                    widget.agenda.nome,
                    style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 20), 
                  ),
                ),
              ),
              
              // DESCRIÇÃO AGENDA
              Padding(
               padding: const EdgeInsets.fromLTRB(50, 20, 50, 0),
                 child: Center(
                   child: Text(
                   widget.agenda.descricao,
                   textAlign: TextAlign.justify,
                   style:  TextStyle(fontWeight: FontWeight.w100, fontSize: 10), 
                     ),
                 ),
              ),

             // DIVIDER
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 20, 50, 0),
                child: Divider(color:  Color.fromRGBO(255, 107,107, 1), ),
              ),

              // TITULOZINHO PARTICIPANTES
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
                child: Center(
                  child: Text(
                    "PARTICIPANTES",
                    style:  TextStyle(fontWeight: FontWeight.w100, fontSize: 15), 
                  ),
                ),
              ),

              
              // LISTA PARTICIPANTES
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Container(
                  height: 120,
                  child: Scrollbar(
                    isAlwaysShown: true,
                    controller: _scrollController,
                    child: Container(
                      child: FutureBuilder(
                        future: _controller.listarParticipantes(context, widget.agenda.id),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done){
                            return ListView.builder(
                              itemCount: _controller.participantes.length,
                              itemBuilder: (context, index) {
                                var participante = _controller.participantes[index];
                                return InkWell(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(2),
                                    leading:Container(
                                      width: 55,
                                      child: Container(
                                        width: 110,
                                        height: 110,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(55),
                                          child: FotoConvert().retornaFoto(participante.foto)
                                        )
                                      ),
                                    ),
                                    title: Text(
                                      participante.nome,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14
                                      )
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => new OutroUsuario(participante)
                                      )
                                    );
                                  },
                                );
                              },
                            );
                          }
                          else{
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(255, 148, 88, 1)),
                              )
                            );
                          }
                        }
                      )
                    ),
                  )
                ),
              ),

              // BOTÃO PARA SAIR DA AGENDA
              Padding(
                padding: EdgeInsets.fromLTRB(50, 30, 50, 0),
                child: FlatButton.icon(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  icon: Icon(Icons.exit_to_app),//icon image
                  label: Text('Sair da Agenda'),//text to show in button
                  textColor: Colors.white,//button text and icon color.
                  color: Color.fromRGBO(255, 107,107, 1),//button background color
                  onPressed: () {
                    createAlertDialog(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
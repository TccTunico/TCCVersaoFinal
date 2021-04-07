import 'package:flutter/material.dart';
import 'package:tunico/controllers/ingressar_agenda_controller.dart';
import 'package:tunico/data/models/agenda_model.dart';
import 'package:tunico/views/components/FlatButtonExt/index.dart';
import 'package:tunico/views/components/TextFormFieldExt/index.dart';
import 'package:tunico/views/components/foto_convert.dart';

class IngressarAgenda  extends StatefulWidget {
  AgendaModel agenda;

  IngressarAgenda(this.agenda);

  @override
  _IngressarAgendaState createState() => _IngressarAgendaState();
}

class _IngressarAgendaState extends State<IngressarAgenda > {
  final ScrollController _scrollController = ScrollController();
  final _controller = IngressarAgendaController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromRGBO(255, 148, 88, 1),
        title: Text('Ingressar na Agenda', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Form(
          child: ListView(
            children: [

              // IMAGEM AGENDA
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50, 30, 50, 0),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 5,
                        color: Color.fromRGBO(255, 107,107, 1),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(75))
                    ),
                    child: ClipOval(
                      child: FotoConvert().retornaFoto(widget.agenda.foto, grupo: true),
                    ),
                  )
                ),
              ),
              
              // TÍTULO - NOME AGENDA
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 20, 50, 0),
                  child: Center(
                    child: Text(
                      widget.agenda.nome,
                      style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 20
                    ),
                  ),
                ),
              ),
              
              // DESCRIÇÃO AGENDA
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Container(
                  height: 80,
                  child: Scrollbar(
                    isAlwaysShown: true,
                    controller: _scrollController,
                    child: ListView(
                      children: [
                        Text(widget.agenda.descricao, textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ) 
              ),

              // INPUT SENHA
              Padding(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: TextFormFieldExt(
                  labelText: 'Senha',
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  maxLines: 1,
                  prefixIcon: Icon(Icons.vpn_key, color:Color.fromRGBO(255, 148, 88, 1)),
                  controller: _controller.senhaController,
                )
              ),

              // TEXTINHO SENHA
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 5, 50, 0),
                child: Center(
                  child: Text(
                    "Caso a agenda não possuir senha deixe este campo em branco.",
                    style: TextStyle( fontSize:8.8, fontStyle: FontStyle.italic),
                  ),
                ),
              ),

          // BOTÃO PARA INGRESSAR
              Padding(
                padding: EdgeInsets.fromLTRB(50, 30, 50, 0),
                child: FlatButtonExt(
                  text: 'Ingressar',
                  onPressed: () {
                    _controller.ingressar(context, widget.agenda.id);
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
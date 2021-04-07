import 'package:flutter/material.dart';
import 'package:tunico/data/models/agenda_model.dart';
import 'package:tunico/views/components/foto_convert.dart';
import 'package:tunico/views/pages/agenda_page/index.dart';
import 'package:tunico/views/pages/ingressar_agenda/index.dart';

class CardAgenda extends StatelessWidget{
  String id;
  String nome;
  String descricao;
  String foto;
  Image image;
  bool ingressarAgenda;

  CardAgenda({
    this.image,
    this.nome,
    this.descricao,
    this.foto,
    this.id,
    this.ingressarAgenda
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: InkWell(
        onTap: () async {
          var agenda = new AgendaModel(
            id: this.id,
            nome: this.nome,
            descricao: this.descricao,
            foto: this.foto,
          );
          if (ingressarAgenda){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new IngressarAgenda(agenda)
              )
            );
          }
          else{
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new AgendaPage(agenda)
              )
            );
          }
        },
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical:10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 80,
                      height: 80,
                      child: ClipOval(
                        child: FotoConvert().retornaFoto(this.foto, grupo: true)
                      )
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                            child: Text(
                              this.nome,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold)
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            this.descricao,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]
            )
          )
        ),
      )
    );
  }
}
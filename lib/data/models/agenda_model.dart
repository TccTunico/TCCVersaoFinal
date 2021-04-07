
import 'package:cloud_firestore/cloud_firestore.dart';

class AgendaModel {
  String id;
  String nome;
  String descricao;
  String senha;
  String foto;
  Timestamp validade;
  List participantes;

  AgendaModel({this.id, this.nome, this.descricao, this.senha, this.foto, this.validade, this.participantes});

  AgendaModel.fromMap(Map map) {
    this.id = map['id'];
    this.nome = map['nome'];
    this.descricao = map['descricao'];
    this.senha = map['senha'];
    this.foto = map['foto'];
    this.validade = map['validade'];
    this.participantes = map['participantes'];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      'nome': this.nome,
      'descricao': this.descricao,
      'senha': this.senha,
      'foto': this.foto,
      'validade': this.validade,
      'participantes': this.participantes
    };
    return map;
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String idUser;
  String idAgenda;
  Timestamp data;
  String texto;
  String pdfFilePath;

  PostModel({this.idUser, this.idAgenda,this.data, this.texto, this.pdfFilePath});

  PostModel.fromMap(Map map) {
    this.idUser = map['idUser'];
    this.idAgenda = map['idAgenda'];
    this.data = map['data'];
    this.pdfFilePath = map['pdfFilePath'];
    this.texto = map['texto'];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      'idUser': this.idUser,
      'idAgenda': this.idAgenda,
      'data': this.data,
      'pdfFilePath': this.pdfFilePath,
      'texto': this.texto,
    };
    return map;
  }
}
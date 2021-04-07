
class UsuarioModel  {
  String id;
  String nome;
  String instituicao;
  String curso;
  String telefone;
  String foto;
  String email;
  List agendas;

  UsuarioModel({this.id, this.nome, this.instituicao, this.curso, this.telefone, this.foto, this.email, this.agendas});

  UsuarioModel.fromMap(Map map){
    this.id = map['id'];
    this.nome = map['nome'];
    this.instituicao = map['instituicao'];
    this.curso = map['curso'];
    this.telefone = map['telefone']; 
    this.foto = map['foto'];
    this.email = map['email'];
    this.agendas = map['agendas'];
  }

  Map toMap(){
    Map<String, dynamic> map ={
      'nome': this.nome,
      'instituicao': this.instituicao,
      'curso': this.curso,
      'telefone': this.telefone,
      'foto': this.foto,
      'email': this.email,
      'agendas': this.agendas
    };

    return map;
  }
}
import 'dart:convert';

List<OsModel> osModelFromJson(String str) => List<OsModel>.from(json.decode(str).map((x) => OsModel.fromJson(x)));

String osModelToJson(List<OsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OsModel {
  int idUsuario;
  String login;
  String senha;
  String nome;

  OsModel({
    this.idUsuario,
    this.login,
    this.senha,
    this.nome,
  });

  factory OsModel.fromJson(Map<String, dynamic> json) => OsModel(
    idUsuario: json["idUsuario"],
    login: json["login"],
    senha: json["senha"],
    nome: json["nome"],
  );


  factory OsModel.fromJsonNet(Map<String, dynamic> json) => OsModel(
    idUsuario: json["IdUsuario"],
    login: json["Login"],
    senha: json["Senha"],
    nome: json["Nome"],
  );


  Map<String, dynamic> toJson() => {
    "idUsuario": idUsuario,
    "login": login,
    "senha": senha,
    "nome": nome,
  };
}
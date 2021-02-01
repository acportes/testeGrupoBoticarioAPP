import 'package:json_annotation/json_annotation.dart';
import 'package:microblogging_boticario/model/domain/posts.dart';

part 'user.g.dart';

@JsonSerializable()
class Usuario {
  String id;
  String nome;
  String email;
  String senha;
  String image;
  List<Posts> userPosts;

  Usuario({this.id, this.nome, this.email, this.senha, this.image, this.userPosts});

  factory Usuario.fromJson(Map<String, dynamic> json) =>
      _$UsuarioFromJson(json);

  Map<String, dynamic> toJson() => _$UsuarioToJson(this);
}

@JsonSerializable()
class DataUser {
  List<Usuario> users;

  DataUser({this.users});

  factory DataUser.fromJson(Map<String, dynamic> json) =>
      _$DataUserFromJson(json);

  Map<String, dynamic> toJson() => _$DataUserToJson(this);
}
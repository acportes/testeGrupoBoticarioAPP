// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Usuario _$UsuarioFromJson(Map<String, dynamic> json) {
  return Usuario(
    id: json['id'] as String,
    nome: json['nome'] as String,
    email: json['email'] as String,
    senha: json['senha'] as String,
    image: json['image'] as String,
    userPosts: (json['userPosts'] as List)
        ?.map(
            (e) => e == null ? null : Posts.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UsuarioToJson(Usuario instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'email': instance.email,
      'senha': instance.senha,
      'image': instance.image,
      'userPosts': instance.userPosts,
    };

DataUser _$DataUserFromJson(Map<String, dynamic> json) {
  return DataUser(
    users: (json['users'] as List)
        ?.map((e) =>
            e == null ? null : Usuario.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataUserToJson(DataUser instance) => <String, dynamic>{
      'users': instance.users,
    };

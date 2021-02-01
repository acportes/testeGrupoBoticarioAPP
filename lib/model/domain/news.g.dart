// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserNews _$UserNewsFromJson(Map<String, dynamic> json) {
  return UserNews(
    name: json['name'] as String,
    profile_picture: json['profile_picture'] as String,
  );
}

Map<String, dynamic> _$UserNewsToJson(UserNews instance) => <String, dynamic>{
      'name': instance.name,
      'profile_picture': instance.profile_picture,
    };

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    content: json['content'] as String,
    created_at: json['created_at'] as String,
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'content': instance.content,
      'created_at': instance.created_at,
    };

News _$NewsFromJson(Map<String, dynamic> json) {
  return News(
    user: json['user'] == null
        ? null
        : UserNews.fromJson(json['user'] as Map<String, dynamic>),
    message: json['message'] == null
        ? null
        : Message.fromJson(json['message'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'user': instance.user,
      'message': instance.message,
    };

DataNews _$DataNewsFromJson(Map<String, dynamic> json) {
  return DataNews(
    news: (json['news'] as List)
        ?.map(
            (e) => e == null ? null : News.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataNewsToJson(DataNews instance) => <String, dynamic>{
      'news': instance.news,
    };

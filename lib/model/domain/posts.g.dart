// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Posts _$PostsFromJson(Map<String, dynamic> json) {
  return Posts(
    id: json['id'] as String,
    text: json['text'] as String,
    date: json['date'] as String,
  );
}

Map<String, dynamic> _$PostsToJson(Posts instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'date': instance.date,
    };

DataPosts _$DataPostsFromJson(Map<String, dynamic> json) {
  return DataPosts(
    posts: (json['posts'] as List)
        ?.map(
            (e) => e == null ? null : Posts.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataPostsToJson(DataPosts instance) => <String, dynamic>{
      'posts': instance.posts,
    };

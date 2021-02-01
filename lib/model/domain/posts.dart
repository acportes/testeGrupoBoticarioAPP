import 'package:json_annotation/json_annotation.dart';

part 'posts.g.dart';

@JsonSerializable()
class Posts {
  String id;
  String text;
  String date;

  Posts({this.id,this.text, this.date});

  factory Posts.fromJson(Map<String, dynamic> json) =>
      _$PostsFromJson(json);

  Map<String, dynamic> toJson() => _$PostsToJson(this);
}

@JsonSerializable()
class DataPosts {
  List<Posts> posts;

  DataPosts({this.posts});

  factory DataPosts.fromJson(Map<String, dynamic> json) =>
      _$DataPostsFromJson(json);

  Map<String, dynamic> toJson() => _$DataPostsToJson(this);
}
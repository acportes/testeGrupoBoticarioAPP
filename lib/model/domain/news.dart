import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class UserNews {
  String name;
  String profile_picture;

  UserNews({this.name, this.profile_picture});

  factory UserNews.fromJson(Map<String, dynamic> json) =>
      _$UserNewsFromJson(json);

  Map<String, dynamic> toJson() => _$UserNewsToJson(this);
}

@JsonSerializable()
class Message {
  String content;
  String created_at;

  Message({this.content, this.created_at});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

@JsonSerializable()
class News {
  UserNews user;
  Message message;

  News({this.user, this.message});

  factory News.fromJson(Map<String, dynamic> json) =>
      _$NewsFromJson(json);

  Map<String, dynamic> toJson() => _$NewsToJson(this);
}

@JsonSerializable()
class DataNews{
  List<News> news;

  DataNews({this.news});

  factory DataNews.fromJson(Map<String, dynamic> json) =>
      _$DataNewsFromJson(json);

  Map<String, dynamic> toJson() => _$DataNewsToJson(this);
}
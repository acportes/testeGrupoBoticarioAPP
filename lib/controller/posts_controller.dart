import 'package:flutter/material.dart';
import 'package:microblogging_boticario/model/app_model.dart';
import 'package:microblogging_boticario/model/domain/posts.dart';
import 'package:microblogging_boticario/model/service/posts_service.dart';
import 'package:provider/provider.dart';

class PostsController {
  final PostsService postsService = PostsService();

  Future excludePost(context, post) async {
    try{
      AppModel app = Provider.of<AppModel>(context, listen: false);
      List<Posts> userPosts = app.logedUser.userPosts;

      if(userPosts.length == 1)
        throw Exception("Para fins didáticos, é necessário ter ao menos um post por usuário");

      var postToExclude = userPosts.firstWhere((e) => e.id == post.id, orElse: null);

      if(postToExclude == null)
        throw Exception("Post não encontrado para remoção!");

      userPosts.remove(postToExclude);

      app.refreshUserPosts(userPosts);
    }catch(e){
      throw e;
    }
  }

  Future editPost(context, post) async {
    try {
      AppModel app = Provider.of<AppModel>(context, listen: false);
      List<Posts> userPosts = app.logedUser.userPosts;

      var postToEdit = userPosts.firstWhere((e) => e.id == post.id, orElse: null);

      if(postToEdit == null)
        throw Exception("Post não encontrado para edição!");

      postToEdit = post;

      app.refreshUserPosts(userPosts);
    } catch (e) {}
  }

  Future savePost(context, post) async {
    try {
      AppModel app = Provider.of<AppModel>(context, listen: false);
      app.setNewPost(post);
    } catch (e) {
      throw e;
    }
  }
}

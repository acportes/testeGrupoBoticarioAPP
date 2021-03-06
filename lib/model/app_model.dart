import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:microblogging_boticario/model/domain/news.dart';
import 'package:microblogging_boticario/model/domain/posts.dart';
import 'package:microblogging_boticario/model/domain/user.dart';
import 'package:microblogging_boticario/utils/prefs.dart';
import 'package:microblogging_boticario/utils/randomUtils.dart';
import 'package:microblogging_boticario/view/dashBoard/dashBoard_page.dart';

enum AppStates { login, logado, onHome, onNewPost, onNewUser, onLastNews }

enum PageTitle { home, newUser, lastNews }

class AppModel extends ChangeNotifier {
  static final String APP_DATA = "APP_DATA";

  Widget page;
  DataUser dataUser;
  Usuario logedUser;
  AppStates states;
  DataPosts dataPosts;
  DataNews lastNews;
  String pageTitle = "Blogging Boticário";

  AppModel() {
    page = DashBoardPage();
    states = AppStates.login;
    notifyListeners();
  }

  setLogin(logedUser) {
    this.page = DashBoardPage();
    this.states = AppStates.onHome;
    this.logedUser = logedUser;
    notifyListeners();
  }

  setUsers(DataUser dataUser) {
    this.dataUser = dataUser;
    notifyListeners();
  }

  setLogout() {
    this.states = AppStates.login;
    notifyListeners();
  }

  setOnHome() {
    this.states = AppStates.onHome;
    this.pageTitle = "Blogging Boticário";
    notifyListeners();
  }

  setOnNewPost() {
    this.states = AppStates.onNewPost;
    notifyListeners();
  }

  setOnNewUser() {
    this.states = AppStates.onNewUser;
    this.pageTitle = "Cadastro de usuário";
    notifyListeners();
  }

  setOnLastNews() {
    this.states = AppStates.onLastNews;
    this.pageTitle = "Últimas novidades";
    notifyListeners();
  }

  setDataPosts(posts) {
    this.dataPosts = posts;
    notifyListeners();
  }

  setLastNews(lastNews) {
    this.lastNews = lastNews;
    notifyListeners();
  }

  refreshUserPosts(userPosts) {
    this.logedUser.userPosts = userPosts;
    notifyListeners();
  }

  setNewPost(post) {
    post.id = RandomUtils.generateGUID();

    var user = dataUser.users.where((u) => logedUser.id == u.id).first;
    user.userPosts.add(post);
    notifyListeners();
  }

  saveAppData() {
    if (dataUser != null) {
      final json = convert.json.encode(dataUser.toJson());
      Prefs.setString(APP_DATA, json);
    }
  }
}

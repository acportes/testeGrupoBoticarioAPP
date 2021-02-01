import 'package:flutter/material.dart';
import 'package:microblogging_boticario/controller/news_controller.dart';
import 'package:microblogging_boticario/model/app_model.dart';
import 'package:microblogging_boticario/model/service/user_service.dart';
import 'package:microblogging_boticario/utils/alerts.dart';
import 'package:microblogging_boticario/utils/app_colors.dart';
import 'package:microblogging_boticario/view/login/login_page.dart';
import 'package:microblogging_boticario/view/news/cardNews.dart';
import 'package:microblogging_boticario/view/news/lastNews_page.dart';
import 'package:microblogging_boticario/view/posts/newPost_page.dart';
import 'package:microblogging_boticario/view/posts/postCard.dart';
import 'package:microblogging_boticario/view/posts/posts_page.dart';
import 'package:microblogging_boticario/view/usuario/cadastroUsuario_page.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'menu.dart';

class DashBoardPage extends StatefulWidget {
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage>
    with TickerProviderStateMixin {
  Size get size => MediaQuery.of(context).size;
  AnimationController animController;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    AppModel app = Provider.of<AppModel>(context, listen: true);

    return app.states == AppStates.login
        ? LoginPage()
        : Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/splash.png"),
                  fit: BoxFit.cover,
                ),
                color: AppColors.getPrimaryColor()),
            child: Scaffold(
              appBar: AppBar(
                title: Text(app.pageTitle),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.exit_to_app,
                      size: 30,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      onClickLogout(app);
                    },
                  ),
                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: floatingButton(app),
              body: dynamicChild(app),
              bottomNavigationBar: bottomBar(),
            ),
          );
  }

  floatingButton(app) {
    return FloatingActionButton(
      backgroundColor: AppColors.getPrimaryColor(),
      child: Icon(
        app.states == AppStates.onHome ? Icons.add : Icons.home,
        color: Colors.white,
      ),
      tooltip: app.states == AppStates.onHome ? "Adicionar novo post" : "Home",
      onPressed: () {
        onClickNavigationButton(app);
      },
    );
  }

  bottomBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Container(
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.person_add_alt_1_rounded,
                  color: AppColors.getPrimaryDarkColor(),
                ),
                //highlightColor: AppColors.getPrimaryDarkColor(),
                tooltip: "Criar usuário",
                onPressed: () {
                  onClickOnNewUser();
                }),
            SizedBox(width: 80),
            IconButton(
                icon: Icon(
                  Icons.article_rounded,
                  color: AppColors.getPrimaryDarkColor(),
                ),
                tooltip: "Novidades Boticário",
                onPressed: () {
                  onClickOnLastNews();
                }),
          ],
        ),
      ),
    );
  }

  dynamicChild(app) {
    switch (app.states) {
      case AppStates.onNewUser:
        {
          return AnimatedBuilder(
              animation: animController,
              builder: (_, child) {
                return CadastroUsuarioPage();
              });
        }
        break;
      case AppStates.onLastNews:
        {
          return LastNewsPage();
        }
        break;
      default:
        {
          return home(app);
        }
    }
  }

  main() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MicroBlogging - Boticário",
        ),
        backgroundColor: AppColors.getPrimaryDarkColor(),
      ),
      body: Container(
        child: Column(
          children: [
            PostsPage(),
          ],
        ),
      ),
      bottomNavigationBar: Menu(),
    );
  }

  home(app) {
    return PostsPage();
  }

  onClickNavigationButton(app) {
    if (app.states == AppStates.onHome) {
      showDialog(
        context: context,
        builder: (_) => NewPostPage(),
      );
    } else
      Provider.of<AppModel>(context, listen: false).setOnHome();
  }

  onClickOnNewUser() {
    Provider.of<AppModel>(context, listen: false).setOnNewUser();
  }

  onClickOnLastNews() {
    Provider.of<AppModel>(context, listen: false).setOnLastNews();
  }

  onClickLogout(app) {
    customAlert(
      context,
      "Atenção",
      "Deseja realmente sair da aplicação?",
      AlertType.warning,
      [
        DialogButton(
          color: Colors.white,
          child: Text(
            "CANCELAR",
            style: TextStyle(color: AppColors.getPrimaryColor(), fontSize: 15),
          ),
          onPressed: () => Navigator.pop(context),
          width: 150,
        ),
        DialogButton(
          color: Colors.white,
          child: Text(
            "CONFIRMAR",
            style: TextStyle(color: AppColors.getPrimaryColor(), fontSize: 15),
          ),
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
            app.setLogout();
          },
          width: 250,
        ),
      ],
    );
  }
}

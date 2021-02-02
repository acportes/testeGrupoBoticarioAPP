import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:microblogging_boticario/model/app_model.dart';
import 'package:microblogging_boticario/utils/alerts.dart';
import 'package:microblogging_boticario/utils/app_colors.dart';
import 'package:microblogging_boticario/view/login/login_page.dart';
import 'package:microblogging_boticario/view/news/lastNews_page.dart';
import 'package:microblogging_boticario/view/posts/newPost_page.dart';
import 'package:microblogging_boticario/view/posts/posts_page.dart';
import 'package:microblogging_boticario/view/usuario/cadastroUsuario_page.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(
                  ScreenUtil().setWidth(40),
                ),
                child: AppBar(
                  backgroundColor: AppColors.getPrimaryColor(),
                  title: Text(
                    app.pageTitle,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(25),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right:16.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.exit_to_app,
                          size: ScreenUtil().setWidth(30),
                          color: Colors.white,
                        ),
                        onPressed: () {
                          onClickLogout(app);
                        },
                      ),
                    ),
                  ],
                ),
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
    return Container(
      width: ScreenUtil().setWidth(60),
      height: ScreenUtil().setHeight(50),
      child: FloatingActionButton(
        backgroundColor: AppColors.getPrimaryColor(),
        child: Icon(
          app.states == AppStates.onHome ? Icons.add : Icons.home,
          color: Colors.white,
          size: ScreenUtil().setWidth(25),
        ),
        tooltip:
            app.states == AppStates.onHome ? "Adicionar novo post" : "Home",
        onPressed: () {
          onClickNavigationButton(app);
        },
      ),
    );
  }

  bottomBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Container(
        color: Colors.white70,
        height: ScreenUtil().setWidth(56),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.person_add_alt_1_rounded,
                  color: AppColors.getPrimaryDarkColor(),
                  size: ScreenUtil().setWidth(25),
                ),
                tooltip: "Criar usuário",
                onPressed: () {
                  onClickOnNewUser();
                }),
            SizedBox(width: 80),
            IconButton(
                icon: Icon(
                  Icons.article_rounded,
                  color: AppColors.getPrimaryDarkColor(),
                  size: ScreenUtil().setWidth(25),

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
            style: TextStyle(
              color: AppColors.getPrimaryColor(),
              fontSize: ScreenUtil().setSp(15),
            ),
          ),
          onPressed: () => Navigator.pop(context),
          width: ScreenUtil().setWidth(150),
        ),
        DialogButton(
          color: Colors.white,
          child: Text(
            "CONFIRMAR",
            style: TextStyle(
              color: AppColors.getPrimaryColor(),
              fontSize: ScreenUtil().setSp(15, allowFontScalingSelf: true),
            ),
          ),
          onPressed: () {
            Provider.of<AppModel>(context, listen: false).saveAppData();
            Navigator.of(context).popUntil((route) => route.isFirst);
            app.setLogout();
          },
          width: ScreenUtil().setWidth(250),
        ),
      ],
    );
  }
}

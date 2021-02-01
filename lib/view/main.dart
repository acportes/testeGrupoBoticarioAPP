import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:microblogging_boticario/model/app_model.dart';
import 'package:microblogging_boticario/utils/app_colors.dart';
import 'package:microblogging_boticario/view/dashBoard/dashBoard_page.dart';
import 'package:microblogging_boticario/view/splashScreen/splash_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

/*
  COMANDO PARA GERAR AS CLASSES .G.DART PARA PARSER DE JSON
  flutter packages pub run build_runner build
 */

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppModel(),
          child: MyApp(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _theme(),
        home: DashBoardPage(),
      ),
    );
  }

  ThemeData _theme() {
    return ThemeData(
      primaryColorDark: Color.fromRGBO(73, 44, 38, 1),
      primaryColor: Color.fromRGBO(250, 54, 74, 1),
      textTheme:
          TextTheme(headline6: TextStyle(color: Color.fromRGBO(73, 44, 38, 1))),
    );
  }
}

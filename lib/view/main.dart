import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:microblogging_boticario/model/app_model.dart';
import 'package:microblogging_boticario/utils/app_colors.dart';
import 'package:microblogging_boticario/view/dashBoard/dashBoard_page.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return ScreenUtilInit(
      designSize: Size(360, 720),
      allowFontScaling: false,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AppModel(),
            child: MyApp(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: _theme(),
          home: _splashScreen(),
        ),
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

  _splashScreen() {
    return SplashScreen(
      seconds: 4,
      navigateAfterSeconds: new DashBoardPage(),
      title: new Text(
        'Grupo Boticário - MicroBlogging',
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize:  20.0,
          color: Colors.white,
        ),
      ),
      image: new Image.asset("assets/images/splash.png"),
      backgroundColor: AppColors.getPrimaryColor(),
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      loaderColor: Colors.white,
    );
  }
}

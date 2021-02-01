import 'package:flutter/material.dart';
import 'package:microblogging_boticario/utils/app_colors.dart';
import 'package:microblogging_boticario/view/dashBoard/dashBoard_page.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      home: DashBoardPage(),
      duration: 3000,
      imageSize: 500,
      imageSrc: "assets/images/B.png",
      text: "Grupo Boticário",
      textType: TextType.TyperAnimatedText,
      textStyle: TextStyle(
        fontSize: 30.0,
      ),
      backgroundColor: AppColors.getPrimaryColor(),
    );
  }
}

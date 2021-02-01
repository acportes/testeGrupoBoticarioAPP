import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:microblogging_boticario/utils/app_colors.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      backgroundColor: Colors.white,
      activeColor: AppColors.getPrimaryColor(),
      color: AppColors.getPrimaryDarkColor(),
      height: 50,
      style: TabStyle.react,
      items: [
        TabItem(icon: Icons.person_add_alt_1_rounded, title: 'Usuário'),
        TabItem(icon: Icons.home, title: 'Home'), //shop
        TabItem(icon: Icons.article_rounded, title: 'Novidades'),
      ],
      initialActiveIndex: 2,
      //optional, default as 0
      onTap: (int i) => print('Clicou no indice=$i'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:microblogging_boticario/controller/news_controller.dart';
import 'package:microblogging_boticario/model/app_model.dart';
import 'package:microblogging_boticario/utils/app_colors.dart';
import 'package:microblogging_boticario/view/news/cardNews.dart';
import 'package:provider/provider.dart';

class LastNewsPage extends StatefulWidget {
  @override
  _LastNewsPageState createState() => _LastNewsPageState();
}

class _LastNewsPageState extends State<LastNewsPage> {
  NewsController controller = new NewsController();

  Size get size => MediaQuery.of(context).size;

  @override
  void initState() {
    super.initState();
    controller.getLastNews(context);
  }

  @override
  Widget build(BuildContext context) {
    AppModel app = Provider.of<AppModel>(context, listen: true);
    return app.lastNews == null
        ? Container(
            height: size.height,
            width: size.width,
            child: Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                backgroundColor: AppColors.getPrimaryDarkColor(),
                valueColor: AlwaysStoppedAnimation(
                  AppColors.getPrimaryColor(),
                ),
              ),
            ),
          )
        : contentLayout(app);
  }

  contentLayout(app) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          child: ListView.builder(
              itemCount: app.lastNews.news.length,
              itemBuilder: (context, index) {
                var news = app.lastNews.news[index];
                return CardNews(news);
              }),
        ),
      ),
    );
  }
}

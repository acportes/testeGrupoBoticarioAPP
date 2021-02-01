
import 'package:microblogging_boticario/model/app_model.dart';
import 'package:microblogging_boticario/model/domain/news.dart';
import 'package:microblogging_boticario/model/service/news_service.dart';
import 'package:provider/provider.dart';

class NewsController{
  final NewsService newsService = NewsService();

  Future<DataNews> getLastNews(context) async {
    try {
      DataNews lastNews = await newsService.getLastNews(context);
      Provider.of<AppModel>(context, listen: false).setLastNews(lastNews);
    } catch (e) {
      throw e;
    }
  }
}
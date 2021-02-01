import 'dart:async';
import 'dart:convert' as convert;
import 'package:microblogging_boticario/model/service/requisitor.dart';

import '../domain/news.dart';

class NewsService{

  Future<DataNews> getLastNews(context) async {
    try{

      final url = "https://gb-mobile-app-teste.s3.amazonaws.com/data.json";
      final json = await Requisitor.doGET(url,context);
      final parsedJson = convert.json.decode(json);
      final dataNews = DataNews.fromJson(parsedJson);
      return dataNews;

    }catch(e){
      throw new Exception("Ocorreu um erro ao buscar as últimas notícias");
    }
  }

}
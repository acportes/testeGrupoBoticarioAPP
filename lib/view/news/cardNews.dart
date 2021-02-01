import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:microblogging_boticario/model/domain/news.dart';
import 'package:microblogging_boticario/utils/app_colors.dart';

class CardNews extends StatelessWidget {
  CardNews(this._news);

  final News _news;
  var dateFormat = new DateFormat("dd/MM/yyyy HH:mm");

  getImage() {
    return CachedNetworkImage(
      imageUrl: _news.user.profile_picture,
      placeholder: (context, url) => new CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(
          AppColors.getPrimaryDarkColor(),
        ),
      ),
      errorWidget: (context, url, error) => Image.asset(
        "assets/images/B.png",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      height: 235,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white70, width: 0.5),
            borderRadius: BorderRadius.circular(7)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                    width: 30,
                    height: 30,
                    color: AppColors.getPrimaryColor(),
                    child: getImage()),
              ),
              title: Text(
                _news.user.name,
                style: TextStyle(
                    color: AppColors.getPrimaryColor(),
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                dateFormat.format(DateTime.parse(_news.message.created_at)),
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _news.message.content,
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

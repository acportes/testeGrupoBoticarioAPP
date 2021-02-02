import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
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
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      height: ScreenUtil().setHeight(size.width > 720 ? 180 : 240),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 0.5),
          borderRadius: BorderRadius.circular(7),
        ),
        margin: EdgeInsets.symmetric(
          vertical: 8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(top:16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                      width: ScreenUtil().setWidth(35),
                      height: ScreenUtil().setHeight(40),
                      color: AppColors.getPrimaryColor(),
                      child: getImage()),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(top:16.0),
                child: Text(
                  _news.user.name,
                  style: TextStyle(
                    color: AppColors.getPrimaryColor(),
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(20, allowFontScalingSelf: true),
                  ),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Text(
                  dateFormat.format(DateTime.parse(_news.message.created_at)),
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: ScreenUtil().setSp(17, allowFontScalingSelf: true),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _news.message.content,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: ScreenUtil().setSp(18, allowFontScalingSelf: true),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

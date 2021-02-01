import 'package:flutter/material.dart';
import 'package:microblogging_boticario/model/app_model.dart';
import 'package:microblogging_boticario/model/domain/posts.dart';
import 'package:microblogging_boticario/model/domain/user.dart';
import 'package:microblogging_boticario/view/posts/listPostsPage.dart';
import 'package:microblogging_boticario/view/posts/postCard.dart';
import 'package:provider/provider.dart';

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  Size get size => MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    AppModel app = Provider.of<AppModel>(context, listen: true);

    return ListView.builder(
      itemCount: app.dataUser.users.length,
      itemBuilder: (context, index) {
        return SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: app.dataUser.users[index].userPosts.length,
                itemBuilder: (context, i) {
                  return PostCard(
                      user: app.dataUser.users[index],
                      post: app.dataUser.users[index].userPosts[i]);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

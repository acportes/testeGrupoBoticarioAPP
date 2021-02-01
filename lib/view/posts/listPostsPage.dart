import 'package:flutter/material.dart';
import 'package:microblogging_boticario/model/domain/user.dart';
import 'package:microblogging_boticario/view/posts/postCard.dart';

class ListPostPage extends StatefulWidget {
  final Usuario user;

  ListPostPage({Key key, this.user}) : super(key: key);

  @override
  _ListPostPageState createState() => _ListPostPageState();
}

class _ListPostPageState extends State<ListPostPage> {
  Size get size => MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      child: ListView.builder(
        itemCount: widget.user.userPosts.length,
        itemBuilder: (context, index) {
          return PostCard(
            user: widget.user,
            post: widget.user.userPosts[index],
          );
        },
      ),
    );
  }
}

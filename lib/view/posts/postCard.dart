import 'package:flutter/material.dart';
import 'package:microblogging_boticario/controller/posts_controller.dart';
import 'package:microblogging_boticario/model/app_model.dart';
import 'package:microblogging_boticario/model/domain/posts.dart';
import 'package:microblogging_boticario/model/domain/user.dart';
import 'package:microblogging_boticario/utils/alerts.dart';
import 'package:microblogging_boticario/utils/app_colors.dart';
import 'package:microblogging_boticario/utils/randomUtils.dart';
import 'package:microblogging_boticario/view/posts/newPost_page.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PostCard extends StatefulWidget {
  final Usuario user;
  final Posts post;

  PostCard({Key key, @required this.user, @required this.post})
      : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> with TickerProviderStateMixin {
  Animation _heartAnimation;
  AnimationController _heartAnimationCtrl;
  PostsController controller = PostsController();

  var _isOwnerPost = false;
  var _favorited = false;
  var _bookmarked = false;

  int likeCount = 0;
  String likeText = "";

  @override
  void initState() {
    super.initState();

    _heartAnimationCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2500),
    );

    _heartAnimation = Tween(begin: 20.0, end: 25.0).animate(
      CurvedAnimation(curve: Curves.bounceOut, parent: _heartAnimationCtrl),
    );
  }

  @override
  Widget build(BuildContext context) {
    likeCount = RandomUtils.getRandomInt();
    likeText = likeCount.toString() + " curtidas";

    AppModel app = Provider.of<AppModel>(context, listen: true);
    _verifyOwnerPost(app);
    return Container(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      height: 290,
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
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 30,
                  height: 30,
                  color: AppColors.getPrimaryColor(),
                  child: Image.asset(widget.user.image == null
                      ? "assets/images/ic_new_user.png"
                      : widget.user.image),
                ),
              ),
              title: Text(
                widget.user.nome,
                style: TextStyle(
                    color: AppColors.getPrimaryColor(),
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                widget.post.date,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.post.text,
                overflow: TextOverflow.ellipsis,
                maxLines: 7,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedBuilder(
                  animation: _heartAnimationCtrl,
                  builder: (context, child) {
                    return IconButton(
                      icon: Icon(
                        _favorited ? Icons.favorite : Icons.favorite_outline,
                        color: Colors.redAccent,
                        size: _heartAnimation.value,
                      ),
                      tooltip: "Curtir",
                      onPressed: () {
                        _favorited ? _onFavorited() : _onFavorite();
                      },
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    likeText,
                    style: TextStyle(
                      color: AppColors.getPrimaryColor(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _bookmarked
                        ? Icons.bookmark
                        : Icons.bookmark_border_outlined,
                    color: Colors.redAccent,
                  ),
                  tooltip: "Curtir",
                  onPressed: () {
                    _bookmarked ? _onBookMarked() : _onBookMark();
                  },
                ),
                _isOwnerPost ? _editPanel(app, widget.post) : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _verifyOwnerPost(app) {
    if (widget.user.id == app.logedUser.id) {
      setState(() {
        _isOwnerPost = true;
      });
    }
  }

  _onFavorite() {
    _heartAnimationCtrl.forward();
    setState(() {
      _favorited = true;
      likeCount += 1;
    });
  }

  _onFavorited() {
    _heartAnimationCtrl.reset();
    setState(() {
      _favorited = false;
      likeCount -= 1;
    });
  }

  _onBookMark() {
    setState(() {
      _bookmarked = true;
    });
  }

  _onBookMarked() {
    setState(() {
      _bookmarked = false;
    });
  }

  _editPanel(app, post) {
    return Padding(
      padding: const EdgeInsets.only(left: 60.0),
      child: Container(
        width: 100,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: AppColors.getPrimaryDarkColor(),
              ),
              tooltip: "Editar",
              onPressed: () {
                _onEdit();
              },
            ),
            IconButton(
              icon: Icon(
                Icons.close,
                color: AppColors.getPrimaryDarkColor(),
              ),
              tooltip: "Excluir",
              onPressed: () {
                _onExclude(app, post);
              },
            ),
          ],
        ),
      ),
    );
  }

  _onEdit() {
    showDialog(
      context: context,
      builder: (_) => NewPostPage(
        post: widget.post,
      ),
    );
  }

  _onExclude(app, post) {
    customAlert(
      context,
      "Atenção",
      "Deseja realmente excluir este post?",
      AlertType.warning,
      [
        DialogButton(
          color: Colors.white,
          child: Text(
            "CANCELAR",
            style: TextStyle(color: AppColors.getPrimaryColor(), fontSize: 15),
          ),
          onPressed: () => Navigator.pop(context),
          width: 150,
        ),
        DialogButton(
          color: Colors.white,
          child: Text(
            "CONFIRMAR",
            style: TextStyle(color: AppColors.getPrimaryColor(), fontSize: 15),
          ),
          onPressed: () async {
            try {
              await controller.excludePost(context, post);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Post excluído com sucesso!"),
                duration: const Duration(seconds: 5),
              ));
              app.setOnHome();
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  e.toString().replaceAll("Exception: ", ""),
                ),
                duration: const Duration(seconds: 5),
              ));
            } finally {
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
          },
          width: 250,
        ),
      ],
    );
  }
}

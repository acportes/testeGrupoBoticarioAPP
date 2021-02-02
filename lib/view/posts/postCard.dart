import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:microblogging_boticario/controller/posts_controller.dart';
import 'package:microblogging_boticario/model/app_model.dart';
import 'package:microblogging_boticario/model/domain/posts.dart';
import 'package:microblogging_boticario/model/domain/user.dart';
import 'package:microblogging_boticario/utils/alerts.dart';
import 'package:microblogging_boticario/utils/app_colors.dart';
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

  Size get size => MediaQuery.of(context).size;

  var _isOwnerPost = false;
  var _favorited = false;
  var _bookmarked = false;

  String likeText = "";

  @override
  void initState() {
    super.initState();

    _heartAnimationCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2500),
    );

    _heartAnimation = Tween(begin: 30.0, end: 35.0).animate(
      CurvedAnimation(curve: Curves.bounceOut, parent: _heartAnimationCtrl),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppModel app = Provider.of<AppModel>(context, listen: true);
    _verifyOwnerPost(app);
    return Container(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      height: ScreenUtil().setHeight(size.height > 720 ? 240 : 325),
      width: ScreenUtil().setWidth(size.width),
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
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Container(
                        width: ScreenUtil().setWidth(35),
                        height: ScreenUtil().setHeight(40),
                        color: AppColors.getPrimaryColor(),
                        child: Image.asset(
                          widget.user.image == null
                              ? "assets/images/ic_new_user.png"
                              : widget.user.image,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        widget.user.nome,
                        style: TextStyle(
                          color: AppColors.getPrimaryColor(),
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(20),
                        ),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                      child: Text(
                        widget.post.date,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: ScreenUtil().setSp(16),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.post.text,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 7,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: ScreenUtil().setSp(16),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: ScreenUtil().setWidth(200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedBuilder(
                      animation: _heartAnimationCtrl,
                      builder: (context, child) {
                        return IconButton(
                          icon: Icon(
                            _favorited
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: AppColors.getPrimaryColor(),
                            size: ScreenUtil().setHeight(_heartAnimation.value),
                          ),
                          tooltip: "Curtir",
                          onPressed: () {
                            _favorited ? _onFavorited() : _onFavorite();
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        _bookmarked
                            ? Icons.bookmark
                            : Icons.bookmark_border_outlined,
                        color: AppColors.getPrimaryColor(),
                        size: ScreenUtil().setHeight(30),
                      ),
                      tooltip: "Curtir",
                      onPressed: () {
                        _bookmarked ? _onBookMarked() : _onBookMark();
                      },
                    ),
                    _isOwnerPost ? _editPanel(app, widget.post) : Container(),
                  ],
                ),
              ),
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
    });
  }

  _onFavorited() {
    _heartAnimationCtrl.reset();
    setState(() {
      _favorited = false;
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
    return Container(
      width: ScreenUtil().setWidth(100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: AppColors.getPrimaryDarkColor(),
              size: ScreenUtil().setHeight(30),
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
              size: ScreenUtil().setHeight(30),
            ),
            tooltip: "Excluir",
            onPressed: () {
              _onExclude(app, post);
            },
          ),
        ],
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
            style: TextStyle(
              color: AppColors.getPrimaryColor(),
              fontSize: ScreenUtil().setSp(15, allowFontScalingSelf: true),
            ),
          ),
          onPressed: () => Navigator.pop(context),
          width: 150,
        ),
        DialogButton(
          color: Colors.white,
          child: Text(
            "CONFIRMAR",
            style: TextStyle(
              color: AppColors.getPrimaryColor(),
              fontSize: ScreenUtil().setSp(15, allowFontScalingSelf: true),
            ),
          ),
          onPressed: () async {
            try {
              await controller.excludePost(context, post);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "Post excluído com sucesso!",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(20),
                  ),
                ),
                duration: const Duration(seconds: 5),
              ));
              app.setOnHome();
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  e.toString().replaceAll("Exception: ", ""),
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(20),
                  ),
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:microblogging_boticario/controller/posts_controller.dart';
import 'package:microblogging_boticario/model/app_model.dart';
import 'package:microblogging_boticario/model/domain/posts.dart';
import 'package:microblogging_boticario/utils/app_colors.dart';
import 'package:microblogging_boticario/utils/dateUtils.dart';
import 'package:microblogging_boticario/utils/textFieldDecoration.dart';
import 'package:provider/provider.dart';

class NewPostPage extends StatefulWidget {
  final Posts post;

  NewPostPage({Key key, @required this.post}) : super(key: key);

  @override
  _NewPostPageState createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage>
    with SingleTickerProviderStateMixin {
  Size get size => MediaQuery.of(context).size;

  PostsController controller = PostsController();

  var _ctrlText = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _progress = false;
  var _editMode = false;

  @override
  void initState() {
    super.initState();

    if (widget.post != null) {
      _editMode = true;
      _ctrlText = TextEditingController(text: widget.post.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppModel app = Provider.of<AppModel>(context, listen: true);

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: ScreenUtil().setHeight(466),
          width: ScreenUtil().setWidth(320),
          decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0))),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: body(app),
          ),
        ),
      ),
    );
  }

  body(app) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                _editMode ? "Edição de Post" : "Novo Post",
                style: TextStyle(
                  color: AppColors.getPrimaryColor(),
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(24, allowFontScalingSelf: true),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Text(
                    "Olá, ",
                    style: TextStyle(
                      color: AppColors.getPrimaryColor(),
                      fontWeight: FontWeight.bold,
                      fontSize:
                          ScreenUtil().setSp(18, allowFontScalingSelf: true),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Container(
                    width: ScreenUtil().setWidth(230),
                    child: Text(
                      app.logedUser.nome,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.getPrimaryDarkColor(),
                        fontWeight: FontWeight.bold,
                        fontSize:
                            ScreenUtil().setSp(18, allowFontScalingSelf: true),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "Edite aqui o texto do seu post. Ele será atualizado e compartilhado com todos!",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.3),
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(18, allowFontScalingSelf: true),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Container(
                width: ScreenUtil().setWidth(size.width),
                height: ScreenUtil().setHeight(170),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  maxLength: 280,
                  maxLines: 5,
                  controller: _ctrlText,
                  validator: _validateText,
                  style: TextStyle(
                    fontSize:
                        ScreenUtil().setSp(16, allowFontScalingSelf: true),
                  ),
                  decoration: TextFieldDecoration.FieldDecoration(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                width: size.width,
                height: ScreenUtil().setHeight(40),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.getPrimaryColor(),
                  ),
                  child: Text(
                    _editMode ? "SALVAR" : "CRIAR",
                    style: TextStyle(
                      fontSize:
                          ScreenUtil().setSp(16, allowFontScalingSelf: true),
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    _onClickButton();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _validateText(text) {
    if (text.isEmpty) return "É necessário informar o texto!";
    return null;
  }

  _onClickButton() async {
    final text = _ctrlText.text;

    if (!_formKey.currentState.validate()) return;

    setState(() {
      _progress = true;
    });

    try {
      if (_editMode) {
        var data = DateUtils.getDateTimeNowString();
        widget.post.text = text;
        widget.post.date = data;
        await controller.editPost(context, widget.post);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Post editado com sucesso!",
            style: TextStyle(
              fontSize: ScreenUtil().setSp(20),
            ),
          ),
          duration: const Duration(seconds: 5),
        ));
      } else {
        Posts post = Posts();
        post.date = DateUtils.getDateTimeNowString();
        post.text = text;
        await controller.savePost(context, post);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Post criado com sucesso!",
            style: TextStyle(
              fontSize: ScreenUtil().setSp(20),
            ),
          ),
          duration: const Duration(seconds: 5),
        ));
      }
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
      setState(() {
        _progress = false;
      });
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }
}

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:microblogging_boticario/controller/users_controller.dart';
import 'package:microblogging_boticario/model/app_model.dart';
import 'package:microblogging_boticario/model/domain/posts.dart';
import 'package:microblogging_boticario/model/domain/user.dart';
import 'package:microblogging_boticario/utils/app_colors.dart';
import 'package:microblogging_boticario/utils/textFieldDecoration.dart';
import 'package:provider/provider.dart';

class CadastroUsuarioPage extends StatefulWidget {
  @override
  _CadastroUsuarioPageState createState() => _CadastroUsuarioPageState();
}

class _CadastroUsuarioPageState extends State<CadastroUsuarioPage>
    with TickerProviderStateMixin {
  AnimationController animController;

  Size get size => MediaQuery.of(context).size;

  UsersController controller = UsersController();

  final _controllerNome = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerSenha = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _progress = false;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
        duration: const Duration(milliseconds: 20000), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    AppModel app = Provider.of<AppModel>(context, listen: true);

    return AnimatedBuilder(
      animation: animController,
      builder: (_, child) {
        return Container(
          width: ScreenUtil().setWidth(size.width),
          height: ScreenUtil().setHeight(size.height),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Text(
                  "Registro",
                  style: TextStyle(
                    color: AppColors.getPrimaryColor(),
                    fontWeight: FontWeight.bold,
                    fontSize:
                        ScreenUtil().setSp(30, allowFontScalingSelf: true),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16,top: 16, right: 16),
                child: Text(
                  "Registre um novo usuário para que ele possa cadastrar, editar e excluir novos posts.",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.3),
                    fontWeight: FontWeight.bold,
                    fontSize:
                        ScreenUtil().setSp(20, allowFontScalingSelf: true),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nome",
                        style: TextStyle(
                          color: AppColors.getPrimaryDarkColor(),
                          fontSize: ScreenUtil()
                              .setSp(15, allowFontScalingSelf: true),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Container(
                          width: ScreenUtil().setWidth(300),
                          height: ScreenUtil().setHeight(60),
                          child: TextFormField(
                            controller: _controllerNome,
                            validator: _validateNome,
                            keyboardType: TextInputType.text,
                            maxLength: 30,
                            style: TextStyle(
                              fontSize: ScreenUtil()
                                  .setSp(16, allowFontScalingSelf: true),
                            ),
                            decoration: TextFieldDecoration.FieldDecoration(),
                          ),
                        ),
                      ),
                      Text(
                        "E-mail",
                        style: TextStyle(
                          color: AppColors.getPrimaryDarkColor(),
                          fontSize: ScreenUtil()
                              .setSp(15, allowFontScalingSelf: true),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Container(
                          width: ScreenUtil().setWidth(300),
                          height: ScreenUtil().setHeight(60),
                          child: TextFormField(
                            controller: _controllerEmail,
                            validator: _validateEmail,
                            keyboardType: TextInputType.text,
                            maxLength: 30,
                            style: TextStyle(
                              fontSize: ScreenUtil()
                                  .setSp(16, allowFontScalingSelf: true),
                            ),
                            decoration: TextFieldDecoration.FieldDecoration(),
                          ),
                        ),
                      ),
                      Text(
                        "Senha",
                        style: TextStyle(
                          color: AppColors.getPrimaryDarkColor(),
                          fontSize: 15,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Container(
                          width: ScreenUtil().setWidth(300),
                          height: ScreenUtil().setHeight(60),
                          child: TextFormField(
                            controller: _controllerSenha,
                            validator: _validateSenha,
                            keyboardType: TextInputType.text,
                            maxLength: 30,
                            obscureText: true,
                            style: TextStyle(
                              fontSize: ScreenUtil()
                                  .setSp(16, allowFontScalingSelf: true),
                            ),
                            decoration: TextFieldDecoration.FieldDecoration(),
                          ),
                        ),
                      ),
                      _progress
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 40.0),
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  child: CircularProgressIndicator(
                                    backgroundColor:
                                        AppColors.getPrimaryDarkColor(),
                                    valueColor: AlwaysStoppedAnimation(
                                      AppColors.getPrimaryColor(),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                width: ScreenUtil().setWidth(300),
                                height: ScreenUtil().setHeight(45),
                                child: RaisedButton(
                                  color: AppColors.getPrimaryColor(),
                                  child: Text(
                                    "SALVAR",
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(16,
                                          allowFontScalingSelf: true),
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    enabled:
                                    _progress == true
                                        ? null
                                        : _onSave(context, app);
                                  },
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _validateNome(String text) {
    if (text.isEmpty) return "É necessário informar um nome";
    return null;
  }

  String _validateEmail(String text) {
    if (text.isEmpty) return "É necessário informar um e-mail";

    var isEmailValid = EmailValidator.validate(text);
    if (!isEmailValid) return "E-mail inválido!";

    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) return "É necessário informar uma senha";
    return null;
  }

  _onSave(context, app) async {
    final nome = _controllerNome.text;
    final email = _controllerEmail.text;
    final senha = _controllerSenha.text;

    if (!_formKey.currentState.validate()) return;

    setState(() {
      _progress = true;
    });

    try {
      Usuario user = Usuario();
      user.nome = nome;
      user.email = email;
      user.senha = senha;
      user.userPosts = List<Posts>();

      await controller.setNewUser(user, context);

      app.setOnHome();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Usuário cadastrado com sucesso!",
          style: TextStyle(
            fontSize: ScreenUtil().setSp(20),
          ),
        ),
        duration: const Duration(seconds: 5),
      ));
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
    }
  }
}

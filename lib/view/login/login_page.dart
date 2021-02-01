import 'package:flutter/material.dart';
import 'package:microblogging_boticario/controller/users_controller.dart';
import 'package:microblogging_boticario/model/app_model.dart';
import 'package:microblogging_boticario/model/domain/user.dart';
import 'package:microblogging_boticario/model/service/user_service.dart';
import 'package:microblogging_boticario/utils/alerts.dart';
import 'package:microblogging_boticario/utils/app_colors.dart';
import 'package:microblogging_boticario/utils/textFieldDecoration.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Size get size => MediaQuery.of(context).size;

  UsersController controller = UsersController();

  final _ctrlEmail = TextEditingController(text: "andrecportes@email.com");
  final _ctrlSenha = TextEditingController(text: "1234");

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _progress = false;

  @override
  Widget build(BuildContext context) {
    AppModel app = Provider.of<AppModel>(context, listen: true);

    return Container(
      width: size.width,
      height: size.height,
      color: AppColors.getPrimaryColor(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            child: Image.asset(
              "assets/images/splash.png",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Container(
                width: size.width,
                height: 300,
                child: _progress
                    ? Container(
                        width: 35,
                        height: 35,
                        child: CircularProgressIndicator(
                          backgroundColor: AppColors.getPrimaryDarkColor(),
                          valueColor: AlwaysStoppedAnimation(
                            AppColors.getPrimaryColor(),
                          ),
                        ),
                      )
                    : Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 40, top: 32),
                                  child: Text(
                                    "E-mail",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.getPrimaryDarkColor(),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, top: 16.0),
                                      child: Icon(
                                        Icons.person,
                                        color: AppColors.getPrimaryDarkColor(),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0, top: 8),
                                      child: Container(
                                        height: 60,
                                        width: 280,
                                        child: TextFormField(
                                          controller: _ctrlEmail,
                                          validator: _validateEmail,
                                          keyboardType: TextInputType.text,
                                          maxLength: 25,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                          decoration: TextFieldDecoration
                                              .FieldDecoration(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 40, top: 8),
                                  child: Text(
                                    "Senha",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.getPrimaryDarkColor(),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, top: 16.0),
                                      child: Icon(
                                        Icons.lock,
                                        color: AppColors.getPrimaryDarkColor(),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0, top: 8),
                                      child: Container(
                                        height: 60,
                                        width: 280,
                                        child: TextFormField(
                                          controller: _ctrlSenha,
                                          validator: _validateSenha,
                                          keyboardType: TextInputType.text,
                                          maxLength: 10,
                                          obscureText: true,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                          decoration: TextFieldDecoration
                                              .FieldDecoration(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Center(
                                child: Container(
                                  width: 200,
                                  height: 45,
                                  child: RaisedButton(
                                    color: AppColors.getPrimaryColor(),
                                    child: Text(
                                      "LOGIN",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () {
                                      _onClickLogin(app);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _validateEmail(String text) {
    if (text.isEmpty) return "É necessário informar um e-mail";
    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) return "É necessário informar uma senha";
    return null;
  }

  _onClickLogin(app) async {
    final email = _ctrlEmail.text;
    final senha = _ctrlSenha.text;

    if (!_formKey.currentState.validate()) return;

    setState(() {
      _progress = true;
    });

    try {
      await controller.getUsers(context);
      Usuario logedUser = await controller.validateUser(email, senha, context);
      if (logedUser == null) {
        throw Exception("Usuário e/ou senha inválidos!");
      }
      app.setLogin(logedUser);
    } catch (e) {
      String mensagem = e.toString();
      alert(context, "Erro", "Ocorreu um erro ao realizar o login : $mensagem",
          TipoDialog.DIALOG_ERRO);
    } finally {
      setState(() {
        _progress = false;
      });
    }
  }
}

import 'package:flutter/material.dart';
import 'package:microblogging_boticario/controller/users_controller.dart';
import 'package:microblogging_boticario/model/app_model.dart';
import 'package:microblogging_boticario/model/domain/user.dart';
import 'package:microblogging_boticario/utils/alerts.dart';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 32, top: 32),
                child: Text(
                  "Registro",
                  style: TextStyle(
                    color: AppColors.getPrimaryColor(),
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32.0, top: 8),
                child: Text(
                  "Registre um novo usuário para que ele possa cadastrar, editar e excluir novos posts.",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.3),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32.0, top: 32),
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
                          fontSize: 15,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Container(
                          width: 300,
                          height: 60,
                          child: TextFormField(
                            controller: _controllerNome,
                            validator: _validateNome,
                            keyboardType: TextInputType.text,
                            maxLength: 30,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            decoration: TextFieldDecoration.FieldDecoration(),
                          ),
                        ),
                      ),
                      Text(
                        "E-mail",
                        style: TextStyle(
                          color: AppColors.getPrimaryDarkColor(),
                          fontSize: 15,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Container(
                          width: 300,
                          height: 60,
                          child: TextFormField(
                            controller: _controllerEmail,
                            validator: _validateEmail,
                            keyboardType: TextInputType.text,
                            maxLength: 30,
                            style: TextStyle(
                              fontSize: 16,
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
                          width: 300,
                          height: 60,
                          child: TextFormField(
                            controller: _controllerSenha,
                            validator: _validateSenha,
                            keyboardType: TextInputType.text,
                            maxLength: 30,
                            obscureText: true,
                            style: TextStyle(
                              fontSize: 16,
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
                                width: 300,
                                height: 45,
                                child: RaisedButton(
                                  color: AppColors.getPrimaryColor(),
                                  child: Text(
                                    "SALVAR",
                                    style: TextStyle(
                                      fontSize: 16,
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

      await controller.setUser(user, context);
      alert(context, "Sucesso", "Usuário salvo com sucesso!",
          TipoDialog.DIALOG_INFORMACAO);
      app.setOnHome();
    } catch (e) {
      String mensagem = e.toString();
      alert(context, "Erro", "Ocorreu um erro ao salvar o usuário : $mensagem",
          TipoDialog.DIALOG_ERRO);
    } finally {
      setState(() {
        _progress = false;
      });
    }
  }
}

/*

                      Text(
                        "Email",
                        style: TextStyle(
                          color: AppColors.getPrimaryDarkColor(),
                          fontSize: 15,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Container(
                          width: 300,
                          height: 60,
                          child: TextFormField(
                            enabled: _progress == true ? false : true,
                            controller: _ctrlEmail,
                            validator: _validateEmail,
                            keyboardType: TextInputType.text,
                            maxLength: 30,
                            style: TextStyle(
                              fontSize: 16,
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
                          width: 300,
                          height: 60,
                          child: TextFormField(
                            enabled: _progress == true ? false : true,
                            controller: _ctrlSenha,
                            validator: _validateSenha,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            maxLength: 15,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            decoration: TextFieldDecoration.FieldDecoration(),
                          ),
                        ),
                      ),
 */

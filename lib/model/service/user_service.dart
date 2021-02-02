import 'dart:math';

import 'package:microblogging_boticario/model/domain/posts.dart';
import 'package:microblogging_boticario/model/domain/user.dart';
import 'dart:convert' as convert;

import 'package:microblogging_boticario/utils/prefs.dart';
import 'package:microblogging_boticario/utils/randomUtils.dart';
import 'package:provider/provider.dart';

import '../app_model.dart';

class UserService {
  Future<DataUser> getUsers(context) async {
    var appJson = await Prefs.getString(AppModel.APP_DATA);

    if (appJson.isEmpty) {
      List<Usuario> listUsuarios = listFakeUsers();
      DataUser dataUser = DataUser();
      dataUser.users = listUsuarios;
      return dataUser;
    } else {
      var usersDecoded = convert.json.decode(appJson);
      var dataUser = DataUser.fromJson(usersDecoded);
      return dataUser;
    }
  }

  Future<void> setUsers(dataUser, context) async {
    Provider.of<AppModel>(context, listen: false).setUsers(dataUser);
  }

  Future<Usuario> validateUser(email, senha, context) async {

    AppModel app = Provider.of<AppModel>(context, listen: false);
    List<Usuario> listUsuarios = app.dataUser.users;

    var user = listUsuarios.firstWhere(
        (u) =>
            u.senha.toUpperCase() == senha.toString().toUpperCase() &&
            u.email.toUpperCase() == email.toString().toUpperCase(),
        orElse: () => null);

    return user;
  }

  Future<bool> userEmailExists(email, context) async {
    AppModel app = Provider.of<AppModel>(context, listen: false);
    List<Usuario> listUsuarios = app.dataUser.users;

    var result = listUsuarios.firstWhere(
        (u) => u.email.toUpperCase() == email.toString().toUpperCase(),
        orElse: () => null);

    if(result == null)
      return false;

    return true;
  }

  List<Usuario> listFakeUsers() {
    List<Usuario> listUsuario = List<Usuario>();

    Usuario usuario1 = Usuario();
    usuario1.id = RandomUtils.generateGUID();
    usuario1.nome = "Luiz Pontes";
    usuario1.email = "luiz_pontes@email.com";
    usuario1.senha = "1234";
    usuario1.image = "assets/images/ic_male_1.png";
    usuario1.userPosts = List<Posts>();
    Posts post0 = Posts();
    post0.id = RandomUtils.generateGUID();
    post0.text =
        "Como manter os cabelos hidratados no verão? A dica é certa: faça hidratação no cabelo! Mantenha a rotina de cuidados e aposte no uso das máscaras capilares, que promovem uma hidratação profunda e intensa nos fios. Existem diversos kits de produtos para cabelo! ";
    post0.date = "20/01/2020 08:40";
    Posts post1 = Posts();
    post1.id = RandomUtils.generateGUID();
    post1.text =
        "Como proteger os cabelos no verão? Além de lavar, condicionar e hidratar, você pode apostar em um creme para pentear sem enxágue. O produto deve ser usado preferencialmente nos cabelos limpos e ajuda a desembaraçar e proteger os fios. Alguns produtos ainda ofercem proteção UV!";
    post1.date = "20/01/2020 08:40";
    usuario1.userPosts.add(post0);
    usuario1.userPosts.add(post1);
    listUsuario.add(usuario1);

    Usuario usuario2 = Usuario();
    usuario2.id = RandomUtils.generateGUID();
    usuario2.nome = "Fernando Prattes";
    usuario2.email = "f_prattes@email.com";
    usuario2.senha = "1234";
    usuario2.image = "assets/images/ic_male_2.png";
    usuario2.userPosts = List<Posts>();
    Posts post2 = Posts();
    post2.id = RandomUtils.generateGUID();
    post2.text =
        "O que fazer com o cabelo depois da piscina? Sempre aposte em um bom leave–in para ajudar a proteger os fios da água da piscina. Lave e condicione com o shampoo e condicionador de sua preferência e, após, utilize uma boa máscara de tratamento para recuperar os fios.";
    post2.date = "20/01/2020 08:40";
    usuario2.userPosts.add(post2);
    listUsuario.add(usuario2);

    Usuario usuario3 = Usuario();
    usuario3.id = RandomUtils.generateGUID();
    usuario3.nome = "Lucimara Fernandes";
    usuario3.email = "luci_fernandes@email.com";
    usuario3.senha = "1234";
    usuario3.image = "assets/images/ic_female_1.png";
    usuario3.userPosts = List<Posts>();
    Posts post3 = Posts();
    post3.id = RandomUtils.generateGUID();
    post3.text =
        "Meu cabelo ficou seco e com frizz no verão, o que fazer? Para combater estes efeitos indesejados, aposte no cronograma capilar. Você pode investir em uma linha especifica para hidratar e controlar o frizz, que garante que as cutículas fiquem seladas por muito mais tempo!";
    post3.date = "20/01/2020 08:40";
    usuario3.userPosts.add(post3);
    listUsuario.add(usuario3);

    Usuario usuario4 = Usuario();
    usuario4.id = RandomUtils.generateGUID();
    usuario4.nome = "Lucinda Neves";
    usuario4.email = "lu_neves@email.com";
    usuario4.senha = "1234";
    usuario4.image = "assets/images/ic_female_2.png";
    usuario4.userPosts = List<Posts>();
    Posts post4 = Posts();
    post4.id = RandomUtils.generateGUID();
    post4.text =
        "Como cuidar dos cabelos loiros no verão? Sejam naturais ou tingidos, os cabelos loiros precisam de cuidado redobrado no verão! O segredo é investir na hidratação, nunca deixar de usar o creme para pentear, e a dica de ouro: usar um produto com fator de proteção.";
    post4.date = "20/01/2020 08:40";
    usuario4.userPosts.add(post4);
    listUsuario.add(usuario4);

    Usuario usuario5 = Usuario();
    usuario5.id = RandomUtils.generateGUID();
    usuario5.nome = "Luana Reis";
    usuario5.email = "lucimara_reis@gmail.com";
    usuario5.senha = "1234";
    usuario5.image = "assets/images/ic_female_3.png";
    usuario5.userPosts = List<Posts>();
    Posts post5 = Posts();
    post5.id = RandomUtils.generateGUID();
    post5.text =
        "Meu cabelo desbotou no verão, e agora? Você não cuidou do cabelo no verão e os fios coloridos desbotaram? Calma que a gente te dá aquela forcinha! Neste caso, você pode investir em um revitalizante de cor para recuperar a vivacidade dos fios e o tom que você deseja.";
    post5.date = "20/01/2020 08:40";
    usuario5.userPosts.add(post5);
    listUsuario.add(usuario5);

    return listUsuario;
  }
}

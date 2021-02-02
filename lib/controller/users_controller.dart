import 'package:microblogging_boticario/model/app_model.dart';
import 'package:microblogging_boticario/model/domain/user.dart';
import 'package:microblogging_boticario/model/service/user_service.dart';
import 'package:microblogging_boticario/utils/randomUtils.dart';
import 'package:provider/provider.dart';

class UsersController {
  final UserService service = UserService();

  Future<DataUser> getUsers(context) async {
    DataUser dataUsers = await service.getUsers(context);
    Provider.of<AppModel>(context, listen: false).setUsers(dataUsers);
    return dataUsers;
  }

  Future<void> setNewUser(user, context) async {
    try {
      await this.validateEmail(user.email, context);
      DataUser dataUsers = await this.getUsers(context);
      user.id = RandomUtils.generateGUID();
      user.image = "assets/images/ic_new_user.png";
      dataUsers.users.add(user);
      await service.setUsers(dataUsers, context);
      Provider.of<AppModel>(context, listen: false).setUsers(dataUsers);
    } catch (e) {
      throw e;
    }
  }

  Future<Usuario> validateUser(email, senha, context) async {
    Usuario usuario = await service.validateUser(email, senha, context);
    return usuario;
  }

  Future<void> validateEmail(email, context) async {
    try {
      var emailExists = await service.userEmailExists(email, context);
      if (emailExists) throw Exception("O e-mail informado já existe na base!");
    } catch (e) {
      throw e;
    }
  }
}

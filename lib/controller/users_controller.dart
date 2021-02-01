import 'package:microblogging_boticario/model/app_model.dart';
import 'package:microblogging_boticario/model/domain/user.dart';
import 'package:microblogging_boticario/model/service/user_service.dart';
import 'package:provider/provider.dart';

class UsersController {
  final UserService service = UserService();

  Future<DataUser> getUsers(context) async {
    try {
      DataUser dataUsers = await service.getUsers(context);
      Provider.of<AppModel>(context, listen: false).setUsers(dataUsers);
    } catch (e) {
      throw e;
    }
  }

  Future<void> setUser(user, context) async {
    try {
      DataUser dataUsers = await this.getUsers(context);
      user.id = dataUsers.users.length + 1;
      user.image = "";
      dataUsers.users.add(user);
      await service.setUsers(dataUsers);
      Provider.of<AppModel>(context, listen: false).setUsers(dataUsers);
    } catch (e) {
      throw e;
    }
  }

  Future<Usuario> validateUser(email, senha, context) async {
    try {
      Usuario usuario = await service.validateUser(email, senha, context);
      return usuario;
    } catch (e) {
      throw e;
    }
  }
}

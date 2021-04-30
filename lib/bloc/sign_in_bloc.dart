import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:parcial_two/model/login_model.dart';
import 'package:parcial_two/repository/sign_in_repository.dart';

class LoginBloc implements Bloc {
  Future<Login> signInUser(Login login) {
    return signIn(login);
  }

  @override
  void dispose() {}
}

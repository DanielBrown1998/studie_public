import 'package:app/features/domain/source/user_source_abstract.dart';
import 'package:app/features/domain/entities/user.dart';

class AuthService implements UserSourceAbstract {
  @override
  Future<bool> deleteDataInCLoud() {
    // TODO: implement deleteDataInCLoud
    throw UnimplementedError();
  }

  @override
  Future<bool> login(User user) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<bool> logout(User user) {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<bool> register(User user) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<bool> saveDataInCloud() {
    // TODO: implement saveDataInCloud
    throw UnimplementedError();
  }

  @override
  Future<bool> syncDataInCloud() {
    // TODO: implement syncDataInCloud
    throw UnimplementedError();
  }
}

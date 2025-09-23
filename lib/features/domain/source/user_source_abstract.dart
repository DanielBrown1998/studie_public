import 'package:app/features/domain/entities/user.dart';

abstract class UserSourceAbstract {
  Future<bool> login(User user);
  Future<bool> register(User user);
  Future<bool> logout(User user);
  Future<bool> saveDataInCloud();
  Future<bool> deleteDataInCLoud();
  Future<bool> syncDataInCloud();
}

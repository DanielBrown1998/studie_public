import 'package:app/source/models/user.dart';

abstract class ApiUserWorkflow {
  Future<bool> login(User user);
  Future<bool> register(User user);
  Future<bool> logout(User user);
  Future<bool> saveDataInCloud();
  Future<bool> deleteDataInCLoud();
  Future<bool> syncDataInCloud();
}

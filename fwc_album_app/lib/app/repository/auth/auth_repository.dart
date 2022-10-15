import 'package:fwc_album_app/app/models/register/register_model.dart';

abstract class AuthRepository {
  Future<void> register(RegisterModel registerModel);
  Future<String> login({required String email, required String password});
  Future<void> logout();
}

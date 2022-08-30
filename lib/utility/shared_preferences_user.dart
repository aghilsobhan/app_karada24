import 'package:app_karada24/models/model_shareprefrenec_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SharedPreferencesUser {
  static const _keyValueUserId = 'userId';
  Future putData(ModelSharedPreferencesUser settings) async
  {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt(_keyValueUserId, settings.userId!);
  }
  Future<ModelSharedPreferencesUser> getData() async {
    final preferences = await SharedPreferences.getInstance();
    final userId = preferences.getInt(_keyValueUserId);
    return ModelSharedPreferencesUser( userId: userId);
  }
}
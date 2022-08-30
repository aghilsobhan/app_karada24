import 'package:flutter/cupertino.dart';
import 'package:app_karada24/models/model_shareprefrence_userInfo.dart';
import 'package:app_karada24/models/model_shareprefrenec_user.dart';
import 'package:app_karada24/models/model_tokens_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SharedPreferencesDataToken {
  static const _keyValueToken = 'token';
  static const _keyValueUserId = 'UserId';
  Future putData(ModelSharedPreferencesToken settings) async
  {
    try{
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_keyValueToken, settings.token!);
    await preferences.setInt(_keyValueUserId, settings.userId!);
  }catch(e){
      debugPrint("token error is"+e.toString());
    }
  }

  Future<ModelSharedPreferencesToken> getData() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString(_keyValueToken);
      final userId = preferences.getInt(_keyValueUserId);
      return ModelSharedPreferencesToken(
          token: token,userId: userId);
    }catch(e){
      debugPrint("get token error is"+e.toString());
      return ModelSharedPreferencesToken(
          token: "token");
    }
  }
}
class SharedPreferencesDataRefreshToken {
  static const _keyValueRefreshToken = 'refreshToken';
  Future putData(ModelSharedPreferencesRefreshToken settings) async
  {
    try{
      final preferences = await SharedPreferences.getInstance();
      await preferences.setString(_keyValueRefreshToken, settings.refreshToken!);
    }catch(e){
      debugPrint("token error is"+e.toString());
    }
  }

  Future<ModelSharedPreferencesRefreshToken> getData() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final refreshToken = preferences.getString(_keyValueRefreshToken);
      return ModelSharedPreferencesRefreshToken(refreshToken: refreshToken);
    }catch(e){
      debugPrint("get token error is"+e.toString());
      return ModelSharedPreferencesRefreshToken(
        refreshToken: "refreshToken");
    }
  }
}
class SharedPreferencesDataUser {
  static const _fullname = 'fullname';
  static const _username = 'username';
  static const _email = 'email';
  static const _phoneNumber = 'phoneNumber';
  Future putData(ModelUserInfo settings) async
  {
    try{
      final preferences = await SharedPreferences.getInstance();
      await preferences.setString("setDataUserInfo", settings.fullname!);
      await preferences.setString(_username, settings.username!);
      await preferences.setString(_email, settings.email!);
      await preferences.setString(_phoneNumber, settings.phoneNumber!);
    }catch(e){
      debugPrint("token error is"+e.toString());
    }
  }

  Future<ModelUserInfo> getData() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final fullname = preferences.getString(_fullname);
      final username = preferences.getString(_username);
      final email = preferences.getString(_email);
      final phoneNumber = preferences.getString(_phoneNumber);
      return    ModelUserInfo(fullname: fullname, username: username, email: email, phoneNumber: phoneNumber);
    }catch(e){
      debugPrint("get token error is"+e.toString());
      return    ModelUserInfo(fullname: "fullname", username: "username", email: "email", phoneNumber: "phoneNumber");
    }
  }
}
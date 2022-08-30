import 'dart:convert';
import 'package:app_karada24/models/model_error_data.dart';
import 'package:app_karada24/response/response_recived_faq.dart';
import 'package:app_karada24/response/response_user_info.dart';
import 'package:app_karada24/value/const_string.dart';
import 'package:http/http.dart' as http;

class ApiServiceUserInfo{
  Future<ResponseUserInfo> UserInfo(int userRoleId,String token) async{
    final response=await http.get(
        Uri.parse(ConstString.urlSrvUserInfo+"GetOrganUserInfo?userRoleId=${userRoleId}&orgId=${4}"),
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        }).timeout(Duration(seconds: 30));
    try{
      if (response.statusCode==200){
        var jsonResponse =json.decode(response.body);
        // print(jsonResponse);
        return  ResponseUserInfo.fromJson(jsonResponse);
      }else{
        ModelErrorData(errorData:response.statusCode.toString() );
        throw Exception('خطا در برقراری ارتباط');
      }
    }catch(e)
    {
      throw Exception(e);
    }

  }

}
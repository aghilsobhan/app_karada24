import 'dart:convert';
import 'package:app_karada24/response/response_tct_categories.dart';
import 'package:http/http.dart' as http;
class ApiServiceListTctCategories{
  static const String uRL="https://crm.phx.ir/srvaccount/api/GetOrganDepartments?";
 // static const String uRL="http://192.168.1.102:8082/api/GetOrganDepartments?";
  Future<ResponseTctCategories> listTctCategories(String? token,int orgId) async{
    final response=await http.get(
        Uri.parse(uRL+"orgId="+orgId.toString().trim()),
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        }).timeout(Duration(seconds: 30));
    try{
      //print("ResponseTctCategories ${token}");
      if (response.statusCode==200||response.statusCode==400){
        var jsonResponse =json.decode(response.body);
        // print(jsonResponse);
        return  ResponseTctCategories.fromJson(jsonResponse);
      }else{
        throw Exception('خطا در برقراری ارتباط');
      }
    }catch(e)
    {
      throw Exception(e);
    }
  }
}
import 'dart:convert';
import 'package:app_karada24/response/response_recive_all_products.dart';
import 'package:app_karada24/value/const_string.dart';
import 'package:http/http.dart' as http;
class ApiServiceListProduct{
  Future<ResponseReciveAllProduct> listTickets(String? token,int orgId) async{
    final response=await http.get(

        Uri.parse(ConstString.urlSrvProduct+"GetAllProducts?orgId="+orgId.toString().trim()),
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token",
        }).timeout(Duration(seconds: 30));
    try{
      if (response.statusCode==200||response.statusCode==400){
        var jsonResponse =json.decode(response.body);
       // print(jsonResponse);
        return  ResponseReciveAllProduct.fromJson(jsonResponse);
      }else{
        throw Exception('خطا در برقراری ارتباط');
      }
    }catch(e)
    {
      throw Exception(e);
    }
  }
}
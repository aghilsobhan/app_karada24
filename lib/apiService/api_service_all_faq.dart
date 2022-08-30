import 'dart:convert';
import 'package:app_karada24/models/model_error_data.dart';
import 'package:app_karada24/response/response_recived_faq.dart';
import 'package:app_karada24/value/const_string.dart';
import 'package:http/http.dart' as http;

class ApiServiceListFaq{
  Future<ResponseGetFaq> listTickets(int orgId,int id,String token) async{
    final response=await http.get(
        Uri.parse(ConstString.urlSrvProduct+"GetFaqsForApp?proId="+id.toString().trim()+"&orgId="+orgId.toString().trim()),
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        }).timeout(Duration(seconds: 30));
    try{
      if (response.statusCode==200||response.statusCode==400){
        var jsonResponse =json.decode(response.body);
       // print(jsonResponse);
        return  ResponseGetFaq.fromJson(jsonResponse);
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
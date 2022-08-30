import 'dart:convert';
import 'package:app_karada24/response/response_list_tickets.dart';
import 'package:app_karada24/value/const_string.dart';
import 'package:http/http.dart' as http;

class ApiServiceListTicketsTest{
  Future<List<DataTicket>> listTickets(int? id,String? token) async{
    final response=await http.get(
        Uri.parse(ConstString.urlSrvTicket+"GetUserTickets?userId="+id.toString()),
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        }).timeout(Duration(seconds: 30));
    try{
      print(token.toString());
      if (response.statusCode==200||response.statusCode==400){
        var jsonResponse =json.decode(response.body);
        // debugPrint(jsonResponse);
        return  productFromJson(jsonResponse);
      }else{
        throw Exception('خطا در برقراری ارتباط');
      }
    }catch(e)
    {
      throw Exception(e);
    }

  }

}
import 'dart:convert';
import 'package:app_karada24/models/model_send_ticket.dart';
import 'package:app_karada24/response/response_send_ticket.dart';
import 'package:app_karada24/value/const_string.dart';
import 'package:http/http.dart' as http;
class ApiServiceSendTicket{
  Future<ResponseSendTicket> number(
      ModelSendTicket requestModel,String token) async {
    try {

      final bodyIs = jsonEncode(requestModel.toJson());
      final response = await http.post(
          Uri.parse(ConstString.urlSrvTickets+"Ticket"),
          body: bodyIs,
          headers: {
            "content-type": "application/json",
            "Authorization": "Bearer $token"
          }).timeout(Duration(seconds: 30));
      if (response.statusCode == 200 || response.statusCode == 400) {
       // return response.statusCode;
        return ResponseSendTicket.fromJson(json.decode(response.body));
      } else {
        throw Exception('خطا در برقراری ارتباط');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
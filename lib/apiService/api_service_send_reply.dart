import 'dart:convert';
import 'package:app_karada24/models/model_add_reply.dart';
import 'package:app_karada24/response/response_recived_reply.dart';
import 'package:http/http.dart' as http;
class ApiServiceSendReplyTicket{
 //static const String uRL = "http://192.168.1.102:8083/api/AddReply";
  static const String uRL = "https://crm.phx.ir/srvticket/api/AddReply";
  Future<ResponseReciveReply> number(
      ModelSendReply requestModel,String? token) async {
    try {
      final bodyIs = jsonEncode(requestModel.toJson());
      final response = await http.post(
          Uri.parse(uRL),
          body: bodyIs,
          headers: {
            "content-type": "application/json",
            "Authorization": "Bearer $token"
          }).timeout(Duration(seconds: 30));
      if (response.statusCode == 200 || response.statusCode == 400) {

        return ResponseReciveReply.fromJson(json.decode(response.body));
      } else {
        throw Exception('خطا در برقراری ارتباط');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
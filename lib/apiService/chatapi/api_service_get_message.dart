import 'dart:convert';
import 'package:app_karada24/response/chat/response_message_contact.dart';
import 'package:app_karada24/screen/chat_page/model/model_get_recived_message.dart';
import 'package:app_karada24/value/const_string.dart';
import 'package:http/http.dart' as http;

class ApiServiceListMessage{
  Future<ResponseMessageContact> listMessages(ModelGetReceivedMessage modelGetReceivedMessage,) async{
    final bodyIs = jsonEncode(modelGetReceivedMessage.toJson());
    final response = await http.post(
        Uri.parse(ConstString.urlSrvAccountChatLocal+"GetUserMessages"),
        body: bodyIs,
        headers: {
          "content-type": "application/json",
          "ApiKey": "86567c79dcf5c9f65d73f576855553fa7149bd1761e28f34450568b1e43ae223"
        }).timeout(Duration(seconds: 30));

    try{
      if (response.statusCode==200||response.statusCode==400){
        var jsonResponse =json.decode(response.body);
        // debugPrint(jsonResponse);
        return  ResponseMessageContact.fromJson(jsonResponse);
      }else{
        throw Exception('خطا در برقراری ارتباط');
      }
    }catch(e)
    {
      throw Exception(e);
    }

  }

}
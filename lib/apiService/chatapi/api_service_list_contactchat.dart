import 'dart:convert';
import 'package:app_karada24/getxController/storagedata/StrorageAllData.dart';
import 'package:app_karada24/response/chat/response_get_contact.dart';
import 'package:app_karada24/screen/chat_page/model/model_get_contact.dart';
import 'package:app_karada24/value/const_string.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiServiceListContactChat{
  String? token = Get.find<ControllerGetStorageAllData>().token;
  Future<ResponseReceivedContactChat> listContact(ModelGetReceivedContact modelGetReceivedContact,) async{
    final bodyIs = jsonEncode(modelGetReceivedContact.toJson());
    final response = await http.post(
        Uri.parse(ConstString.urlSrvAccountChatLocal+"GetChatUsers"),
        body: bodyIs,
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        }).timeout(Duration(seconds: 30));

    try{
      if (response.statusCode==200||response.statusCode==400){
        var jsonResponse =json.decode(response.body);
        // debugPrint(jsonResponse);
        return  ResponseReceivedContactChat.fromJson(jsonResponse);
      }else{
        throw Exception('خطا در برقراری ارتباط');
      }
    }catch(e)
    {
      throw Exception(e);
    }

  }

}
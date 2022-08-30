import 'dart:convert';
import 'package:app_karada24/response/ticket/response_get_link_guest_customer.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../../getxController/storagedata/StrorageAllData.dart';
class ApiServiceListGetGuestLinkCustomer{


  Future<ResponseGetGuestLinkedCustomer> listTctCategories(String url,String? token,int userId,int orgId) async{
    final response=await http.get(
        Uri.parse(url.trim()+"userId="+userId.toString().trim()+"&orgId="+orgId.toString().trim()),
        headers: {
          "content-type": "application/json",
          "Authorization": "Bearer $token"
        }).timeout(Duration(seconds: 30));
    try{
      //print("ResponseTctCategories ${token}");
      if (response.statusCode==200||response.statusCode==400){
        var jsonResponse =json.decode(response.body);
        print(jsonResponse);
        return  ResponseGetGuestLinkedCustomer.fromJson(jsonResponse);
      }else{
        throw Exception('خطا در برقراری ارتباط');
      }
    }catch(e)
    {
      print(e);
      throw Exception(e);
    }
  }
}
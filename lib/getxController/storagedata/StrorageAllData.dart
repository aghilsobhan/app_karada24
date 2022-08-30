import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ControllerGetStorageAllData extends GetxController{
  String? token;
  String? refreshToken;
  int? userId;
  int? userRolId;
  int? IsRolId;


  String? userName;
  String? email;
  String? phoneNumber;
  String? fullName;
  int? organId;
  String? organName;

  final box=GetStorage();
  Future<void> saveTokens(tokenD,refToken,userId,userRolId) async{
   await box.write("token", tokenD);
   await box.write("refreshToken", refToken);
   await box.write("userId", userId);
   await box.write("userRolId", userRolId);
   update();
  }
  Future<void> saveIsRolId(IsRolId) async{
    await box.write("IsRolId", IsRolId);
    update();
  }
  Future<void> readIsRolId() async{
    this.IsRolId=await box.read("IsRolId");
    update();
  }
  Future<void> readTokens() async{
    this.token=await box.read("token");
     this.userId=await box.read("userId");
     this.userRolId=await box.read("userRolId");
     this.refreshToken=await box.read("refreshToken");
     update();
  }
  Future<void> saveProfile(userName,email,phoneNumber,fullName,organId,organName) async{
    await box.write("userName", userName);
    await box.write("email", email);
    await box.write("phoneNumber", phoneNumber);
    await box.write("fullName", fullName);
    await box.write("organId", organId);
    await box.write("organName", organName);
    update();
  }
  Future<void> readProfile() async{
    this.userName=await box.read("userName");
    this.email=await box.read("email");
    this.phoneNumber=await box.read("phoneNumber");
    this.fullName=await box.read("fullName");
    this.organId=await box.read("organId");
    this.organName=await box.read("organName");
    update();
  }
}
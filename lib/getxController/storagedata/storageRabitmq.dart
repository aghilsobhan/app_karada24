import 'package:dart_amqp/dart_amqp.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ControllerGetStorageRabbit extends GetxController{
  Client client =Client(settings: ConnectionSettings(
    host: "194.59.171.30",
    authProvider: const PlainAuthenticator("test", "test"),));
 late Channel channel;


  final box=GetStorage();
  Future<void> saveChannel() async{
  box.write("_channel",await client.channel());
    update();
  }
  Future<void> readChannel() async{
  this.channel=await box.read("_channel");
    update();
  }

}
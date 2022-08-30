import 'package:app_karada24/getxController/check_badge_tickets.dart';
import 'package:app_karada24/getxController/storagedata/StrorageAllData.dart';
import 'package:app_karada24/screen/chat_page/controller/get_list_contact.dart';
import 'package:app_karada24/utility/widget_loading_page.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_card.dart';

class TabListContact extends StatefulWidget {
  const TabListContact({Key? key}) : super(key: key);

  @override
  _TabListContactState createState() => _TabListContactState();
}

class _TabListContactState extends State<TabListContact> {
  GetUserChatController _getListContact = Get.find<GetUserChatController>();
  late Future<void> fListTctCategories;
  int? userId = Get.find<ControllerGetStorageAllData>().userId;
  int? isRolId = Get.find<ControllerGetStorageAllData>().IsRolId;
  String? token = Get.find<ControllerGetStorageAllData>().token;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _getListContact.loading.value == false ?
      _getListContact.errors.value.isNotEmpty?
      Center(child: Text(_getListContact.errors.value,style: TextStyle(color: Colors.red),),):
      allListContact()
       : WidgetLoadingPage();
    });
  }
  Widget allListContact() {

    return
      ListView.builder(
          itemCount: _getListContact.listContactChat.length,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (contex, index) {

            return
              CustomCard(
                dataContactChat: _getListContact.listContactChat[index],
              );}) ;

  }
  @override
  void initState() {
    _getListContact.getFetchData(4, userId!,isRolId!);
    super.initState();
  }
}

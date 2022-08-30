import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:app_karada24/screen/chat_page/controller/chat_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class AppBarChatPage extends StatelessWidget implements PreferredSizeWidget {
  final String name;

  //final String isConnect;
  final String image;

  AppBarChatPage({
    required this.name, required this.image,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.find<ChatController>();
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: Obx(() {
      final isConnect= chatController.status.value.toString().contains("success")?"آنلاین"
          :chatController.status.value.toString().contains("reconnection")?"...در حال برقراری ارتباط":"اتصال برقرار نیست";
        return AppBar(
          leadingWidth: 70,
          titleSpacing: 0,
          backgroundColor: Palette.primaryColorD,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                  ),
                ),
                SizedBox(width: 3,),
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: AssetImage(
                    image,
                  ),
                  backgroundColor: Colors.transparent,
                ),
              ],
            ),
          ),
          title: InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.all(6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: "sans"
                    ),
                  ),
                  Text(
                    isConnect,
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: "sans"
                    ),
                  )
                ],
              ),
            ),
          ),
          actions: [
            IconButton(icon: Icon(Icons.videocam), onPressed: () {
              //openChatConnection();
            }),
            IconButton(icon: Icon(Icons.call), onPressed: () {}),
            PopupMenuButton<String>(
              padding: EdgeInsets.all(0),
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (BuildContext contesxt) {
                return [
                  // PopupMenuItem(
                  //   child: Text("View Contact"),
                  //   value: "View Contact",
                  // ),
                  // PopupMenuItem(
                  //   child: Text("Media, links, and docs"),
                  //   value: "Media, links, and docs",
                  // ),
                  // PopupMenuItem(
                  //   child: Text("Whatsapp Web"),
                  //   value: "Whatsapp Web",
                  // ),
                  // PopupMenuItem(
                  //   child: Text("Search"),
                  //   value: "Search",
                  // ),
                  // PopupMenuItem(
                  //   child: Text("Mute Notification"),
                  //   value: "Mute Notification",
                  // ),
                  // PopupMenuItem(
                  //   child: Text("Wallpaper"),
                  //   value: "Wallpaper",
                  // ),
                ];
              },
            ),
          ],
        );
      }),
    );
  }


}

import 'package:flutter/cupertino.dart';

class TabPrivateChat extends StatefulWidget {
  const TabPrivateChat({Key? key}) : super(key: key);

  @override
  _TabPrivateChatState createState() => _TabPrivateChatState();
}

class _TabPrivateChatState extends State<TabPrivateChat> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("private chat"),);
  }
}

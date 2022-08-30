import 'package:flutter/material.dart';
import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:app_karada24/utility/exit_dialog.dart';
import 'package:flutter_svg/svg.dart';
class Tasks extends StatefulWidget {
  final String? token;
  final int? userId;
  const Tasks(this.token, this.userId,{Key? key}) : super(key: key);

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backGroundColorD,
      appBar: AppBar(
        toolbarHeight: 10,
        backgroundColor: Palette.bottomNavUnBack,
        bottom: TabBar(
          labelColor: Colors.black,
          controller: _tabController,
          indicatorColor: Palette.primaryColorD,
          labelStyle:TextStyle(fontFamily: "sans",fontSize: 12) ,
          tabs: [
            Text("انجام شده"),
            Text("در حال انجام"),
            Text("لیست وظایف"),
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        Tasks(),
        Tasks(),
        Tasks(),
      ]),
      floatingActionButton: FloatingActionButton(onPressed: () {  },
        mini: true,
        backgroundColor: Palette.primaryColorD,
        child: Icon(Icons.add_task),

      ),
    );
  }
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, initialIndex: 2, vsync: this);
  }
  Widget Tasks(){
    return Column(
      children:[ Center(
        child:Image.asset("images/vectornulltask1.png",height: 400,width: 250,) ,
      ),
      Text("....در حال توسعه",style: TextStyle(fontFamily: "sans",fontSize: 12),)],
    );
  }
}

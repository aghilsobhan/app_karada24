
import 'package:flutter/material.dart';
import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:persian_number_utility/src/extensions.dart';
import '../../utility/mange_files/manage_files.dart';

class DetailsReplyTicket extends StatefulWidget {
  final String textTicket;
  final String token;
  final int? ownerId;
  final DateTime dataTicket;
  DetailsReplyTicket(this.textTicket,this.ownerId, this.dataTicket, this.token,
      {Key? key})
      : super(key: key);

  @override
  _DetailsReplyTicketState createState() => _DetailsReplyTicketState();
}

class _DetailsReplyTicketState extends State<DetailsReplyTicket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backGroundColorD,
      body: Column(
        children: [
          buildTextFieldBody(),
          Divider(),
          Expanded(child: ListFiles(token:widget.token ,ownerId: widget.ownerId,ownerName: "reply",)),
        ],
      ),
      appBar: AppBar(

        backgroundColor: Palette.bottomNavUnBack,
        toolbarHeight: 45.0,
        leadingWidth: 45,// double
        automaticallyImplyLeading: false,
        actions: [
          SizedBox(height: 15),

          Padding(
            padding: EdgeInsets.only(right: 8),
            child: const Text("جزئیات پیام",
                style: TextStyle(
                    fontFamily: 'sans',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
        ],
        leading: Padding(
          padding: EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width:30,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(25)),
              child: const Icon(
                Icons.close,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),

      ),
    );
  }
  @override
  void initState() {
    super.initState();
  }

  Widget buildTextFieldBody() {
    String date = widget.dataTicket.toString();
    List<String> dt = date.split(" ");
    List<String> time = dt[1].split(".");
    var dtd = date.toPersianDate();
    return GestureDetector(
      child: Padding(
        padding:
            const EdgeInsets.only(right: 10, top: 25, bottom: 10, left: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(time[0],
                    style: const TextStyle(
                        color: Palette.gradient2,
                        fontFamily: "sans",
                        fontSize: 13)),
                Text(dtd,
                    style: const TextStyle(
                        color: Palette.gradient2,
                        fontFamily: "sans",
                        fontSize: 13))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                widget.textTicket,
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                    color: Colors.black, fontFamily: "sans", fontSize: 14,fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }

}

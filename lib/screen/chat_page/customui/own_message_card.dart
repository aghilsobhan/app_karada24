import 'package:flutter/material.dart';

class OwnMessageCard extends StatelessWidget {
  final String message;
  final String status;
  final String time;
  const OwnMessageCard({ Key? key, required this.message, required this.time, required this.status}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
          minWidth:95
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Color(0xffdcf8c6),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 5,
                    bottom: 20,
                  ),
                  child: Text(
                    message,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "sans"
                    ),
                  ),
                ),

                Positioned(
                  bottom:1,
                  right: 6,
                  child: Row(
                    children: [

                   Icon(Icons.check,size: 15,color: Colors.grey,),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                          fontFamily: "sans"
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
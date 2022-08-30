import 'package:flutter/material.dart';

class ReplyCard extends StatelessWidget {
  final String message;
  final String time;
  const ReplyCard({Key? key, required this.message, required this.time}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
          minWidth: 80,
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            // color: Color(0xffdcf8c6),
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

                  bottom: 1,
                  right: 10,
                  child: Text(
                    time,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                      fontFamily: "sans"
                    ),
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

class ChatBubble extends CustomPainter {
  final Color? color;
  final Alignment? alignment;

  ChatBubble({
    @required this.color,
    this.alignment,
  });

  var _radius = 10.0;
  var _x = 10.0;




  @override
  void paint(Canvas canvas, Size size) {
    if (alignment == Alignment.topRight) {
      canvas.drawRRect(
          RRect.fromLTRBAndCorners(
            0,
            0,
            size.width - 8,
            size.height,
            bottomLeft: Radius.circular(_radius),
            topRight: Radius.circular(_radius),
            topLeft: Radius.circular(_radius),
          ),
          Paint()
            ..color = this.color!
            ..style = PaintingStyle.fill);
      var path = new Path();
      path.moveTo(size.width - _x, size.height - 20);
      path.lineTo(size.width - _x, size.height);
      path.lineTo(size.width, size.height);
      canvas.clipPath(path);
      canvas.drawRRect(
          RRect.fromLTRBAndCorners(
            size.width - _x,
            0.0,
            size.width,
            size.height,
            topRight: Radius.circular(_radius),
          ),
          Paint()
            ..color = this.color!
            ..style = PaintingStyle.fill);
    } else {
      canvas.drawRRect(
          RRect.fromLTRBAndCorners(
            _x,
            0,
            size.width,
            size.height,
            bottomRight: Radius.circular(_radius),
            topRight: Radius.circular(_radius),
            topLeft: Radius.circular(_radius),
          ),
          Paint()
            ..color = this.color!
            ..style = PaintingStyle.fill);
      var path = new Path();
      path.moveTo(0, size.height);
      path.lineTo(_x, size.height);
      path.lineTo(_x, size.height-20);
      canvas.clipPath(path);
      canvas.drawRRect(
          RRect.fromLTRBAndCorners(
            0,
            0.0,
            _x,
            size.height,
            topRight: Radius.circular(_radius),
          ),
          Paint()
            ..color = this.color!
            ..style = PaintingStyle.fill);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
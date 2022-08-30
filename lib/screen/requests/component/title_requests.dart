import 'package:flutter/cupertino.dart';

import '../../../value/style_more.dart';


class TitleRequests extends StatelessWidget {
  final String title;
  TitleRequests({
    required this.title
  });
  @override
  Widget build(BuildContext context) {
    return   Container(
      margin: const EdgeInsets.only(left: 8,right: 6),
      padding: const EdgeInsets.only(left: 6, right: 6),
      decoration: BoxDecoration(
        borderRadius : BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        boxShadow : [BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            offset: Offset(0,4),
            blurRadius: 4
        )],
        color : Color.fromRGBO(122, 120, 120, 1),
      ),
      child: Padding(padding: EdgeInsets.only(top: 3,bottom: 3),child: Text(title.toString(),style: StylesMore.styleText)),
    );
  }
}

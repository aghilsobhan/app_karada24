
import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:flutter/material.dart';

class SearchTickets extends StatefulWidget {
  final String text;
  final ValueChanged<String>? onChanged;
  final String hintText;
  const SearchTickets({Key? key, required this.text,
    this.onChanged,
    required this.hintText,}) : super(key: key);

  @override
  _SearchTicketsState createState() => _SearchTicketsState();
}

class _SearchTicketsState extends State<SearchTickets> {

  final controller = TextEditingController();
  bool _folded=true;
  @override
  Widget build(BuildContext context) {
    const styleActive = TextStyle(color: Colors.black,fontFamily: 'sans',fontSize: 12);
    const styleHint = TextStyle(color: Colors.black26 ,fontFamily: 'sans',fontSize: 12);
    final style = widget.text.isEmpty ? styleHint : styleActive;
    return AnimatedContainer(
    duration: Duration(milliseconds: 300),
    width: _folded?32:300,
    height: 32,
    decoration: !_folded?BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color:Colors.white,
    ):null,
    child: Row(
      children: [
        Expanded(
            child: Padding(
          padding: EdgeInsets.only(left: 2,right:3),
          child: !_folded?Directionality(
            textDirection: TextDirection.rtl,
            child: TextField(
              onChanged: widget.onChanged,
              style: style,
         decoration: InputDecoration(
             hintText: widget.hintText,
             hintStyle: style,
             border: InputBorder.none
         ),
            ),
          ):null,
        )),
        AnimatedContainer(duration: Duration(milliseconds: 300),
        child:Material(type: MaterialType.transparency,child: InkWell(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(_folded?16:0),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(_folded?16:0),
            bottomRight: Radius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child:_folded? Icon(Icons.search,
              color:Palette.bottomNavSelected,size: 20,):GestureDetector(
              onTap: () {
                _folded=!_folded;
                controller.clear();
                widget.onChanged!('');
                FocusScope.of(context).requestFocus(FocusNode());
              },
                child: Icon(Icons.close,
                color:Palette.bottomNavSelected,size: 20,),
              )
          ),
          onTap: (){
            setState(() {
              _folded=!_folded;

            });
          },
        )),)
      ],
    ),);
  }
}

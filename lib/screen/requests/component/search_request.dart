import 'package:flutter/material.dart';

class SearchRequest extends StatefulWidget {
  final String text;
  final ValueChanged<String>? onChanged;
  final String hintText;

  const SearchRequest({
    Key? key,
    required this.text,
    this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchRequestState createState() => _SearchRequestState();
}

class _SearchRequestState extends State<SearchRequest> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const styleActive = TextStyle(color: Colors.black,fontFamily: 'sans',fontSize: 12);
    const styleHint = TextStyle(color: Colors.black26 ,fontFamily: 'sans',fontSize: 12);
    final style = widget.text.isEmpty ? styleHint : styleActive;
widget.text.isEmpty?controller.clear():controller;
    return Container(
      height: 35,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        border: Border.all(color: Colors.black26),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            icon: Icon(Icons.search, color: style.color),
            suffixIcon: widget.text.isNotEmpty
                ? GestureDetector(
              child: Icon(Icons.close, color: style.color),
              onTap: () {
                controller.clear();
                widget.onChanged!('');
                FocusScope.of(context).requestFocus(FocusNode());
              },
            )
                : null,
            hintText: widget.hintText,
            hintStyle: style,
            border: InputBorder.none,
          ),
          style: style,
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../materialcolors/materialcolors.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  _TermsAndConditionsState createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40,bottom: 40,right: 13,left: 13),
      child: Container(

          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Palette.gradient2),
            borderRadius: BorderRadius.circular(20),
          ),
          child:
          Container(
            child:Column(children: [

              Padding(
                padding: const EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 30.0,
                      height:30,
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


              const Divider(height: 0.3,color: Palette.gradient2,),
              const SizedBox(height: 10,),
            const  Padding(
                padding: EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text("قوانین و مقررات", style: TextStyle( fontFamily: 'sans',
                        fontSize: 16,
                        color: Colors.black,fontWeight: FontWeight.bold)),
                  ),
                ),
              )]),
          )

      ),
    );
  }
}

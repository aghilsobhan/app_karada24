
import 'package:flutter/material.dart';
import '../materialcolors/materialcolors.dart';

class DescriptionSelectedProduct extends StatefulWidget {
 final String? descriptionProduct;
 final String? nameProduct;
   DescriptionSelectedProduct(this.descriptionProduct,this.nameProduct,{Key? key}) : super(key: key);

  @override
  _DescriptionSelectedProductState createState() => _DescriptionSelectedProductState();
}

class _DescriptionSelectedProductState extends State<DescriptionSelectedProduct> {
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
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,

                    children: [
                     Text(widget.nameProduct.toString(), style: TextStyle( fontFamily: 'sans',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 30.0,
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

                    ],
                  ),
                ),


                const Divider(height: 0.3,color: Palette.gradient2,),
                const SizedBox(height: 10,),
                Padding(
                  padding:const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(widget.descriptionProduct.toString(), style:const TextStyle( fontFamily: 'sans',
                          fontSize: 12,
                          color: Colors.black)),
                    ),
                  ),
                )]),
        )

      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:app_karada24/response/response_recived_faq.dart';
import 'package:flutter_svg/svg.dart';

class SelectFaqList extends StatefulWidget {
  final DatFaq itemSelected;
  final String image;
  const SelectFaqList(this.itemSelected, this.image, {Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _SelectFaqListState createState() => _SelectFaqListState(itemSelected);
}

class _SelectFaqListState extends State<SelectFaqList>
    with SingleTickerProviderStateMixin {
  late DatFaq optionItemSelected;

  late AnimationController expandController;
  late Animation<double> animation;

  bool isShow = false;

  _SelectFaqListState(this.optionItemSelected);

  @override
  void initState() {
    super.initState();
    expandController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    _runExpandCheck();
  }

  void _runExpandCheck() {
    if (isShow) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            isShow = !isShow;
            _runExpandCheck();
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6,vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              border: Border.all(color: Colors.black,width: 0.2),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 4,
                    color: Colors.black26,
                    offset: Offset(0, 2))
              ],
            ),
            child: Row(
           mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[
                Icon(
                  isShow ? Icons.arrow_drop_down : Icons.arrow_right,
                  color: Colors.black,
                  size: 25,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      isShow = !isShow;
                      _runExpandCheck();
                      setState(() {});
                    },
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                       optionItemSelected.faqTittle.toString() ,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: "sans",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizeTransition(

                        sizeFactor: animation,
            child: Column(
              children: [
               const SizedBox(
                  height: 3,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 6,vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black,width: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 4,
                            color: Colors.grey.withOpacity(0.5),
                            offset:const Offset(0, 4))
                      ],
                    ),
                    child: _buildSubMenu(optionItemSelected, context))
              ],
            )),
//          Divider(color: Colors.grey.shade300, height: 1,)
      ],
    );
  }

  Widget _buildSubMenu(DatFaq item, BuildContext context) {
    return Container(
          padding: const EdgeInsets.all(10),
            child: ListView(
              shrinkWrap: true,
            children: [
              ClipOval(
                child: Image.asset(
                  widget.image,
                  width: 50,
                  height: 50,
                  color: Palette.primaryColorD,
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              Directionality(
                textDirection: TextDirection.rtl,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
    minHeight: 50,
    maxHeight: 300,
    ),
                  child: SingleChildScrollView(
                    child: Text(item.faqBody.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: "sans",
                          fontSize: 12),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ),
            ],
              ),
          );

  }
}

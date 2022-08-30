import 'package:flutter/material.dart';
import 'package:app_karada24/response/response_all_help.dart';
import 'package:app_karada24/response/response_recived_faq.dart';
import 'package:flutter_svg/svg.dart';

class SelectHelpList extends StatefulWidget {
  final DataHelp itemSelected;
  final String image;
  const SelectHelpList(this.itemSelected, this.image, {Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _SelectHelpListState createState() => _SelectHelpListState(itemSelected);
}

class _SelectHelpListState extends State<SelectHelpList>
    with SingleTickerProviderStateMixin {
  late DataHelp optionItemSelected;

  late AnimationController expandController;
  late Animation<double> animation;

  bool isShow = false;

  _SelectHelpListState(this.optionItemSelected);

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
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  isShow ? Icons.arrow_drop_down : Icons.arrow_right,
                  color: Colors.black,
                  size: 25,
                ),
                GestureDetector(
                  onTap: () {
                    isShow = !isShow;
                    _runExpandCheck();
                    setState(() {});
                  },
                  child: Text(
                    optionItemSelected.hlpTittle.toString(),
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        fontFamily: "sans"),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: animation,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black,width: 0.1),
                      borderRadius: BorderRadius.circular(10),
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

  Widget _buildSubMenu(DataHelp item, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipOval(
            child: CircleAvatar(
              child: Image.asset(
                widget.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(item.hlpTittle.toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "sans",
                  fontSize: 12),
              maxLines: 3,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}

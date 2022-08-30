import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:app_karada24/response/ticket/response_get_link_guest_customer.dart';
import 'package:app_karada24/value/const_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../apiService/ticket/api_service_getlink_geust_customer.dart';
import '../../getxController/storagedata/StrorageAllData.dart';
import '../../getxController/value_department_id.dart';
import '../../models/drop_down_listmodel.dart';
import '../../utility/snackbar_error.dart';
import '../list_department_radio.dart';


class BottomSheetCustom extends StatefulWidget {
  final Function(String title) valueText;
  final Function(int userDepId) userDepId;
  const BottomSheetCustom({Key? key, required this.valueText, required this.userDepId})
      : super(key: key);

  @override
  _BottomSheetCustomState createState() => _BottomSheetCustomState();
}

class _BottomSheetCustomState extends State<BottomSheetCustom> {
  late Future<void> fListTctCategories;
  late List<DataGetGuestLinkedCustomer> _listDataTct = [];
  DropListModelTctCategories dropListModel = DropListModelTctCategories([]);
  String nameDep = "";
  int depId = -1;
  int userDepId = -1;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              "کارشناس مورد نظر خود را انتخاب کنید:",
              style: TextStyle(
                  fontFamily: "sans",
                  fontSize: 12,
                  color: Palette.primaryColorD,
                  fontWeight: FontWeight.bold),
            ),
            Divider(
              indent: 10,
              endIndent: 10,
            ),
            _listDataTct.length>0?   RadioButton(
                      listDataTct: _listDataTct,
                      callBackName: (String) {
                        setState(() {});
                        return nameDep = String;
                      },
                      callBackDep: (int) {
                        setState(() {});
                        return depId = int;
                      },
                      callBackuserDepId: (int ) {
                      setState(() {});
                      return userDepId = int;
                    },
                    ):  Text(
              "کارشناس پاسخگویی برا شما ثبت نشده",
              style: TextStyle(
                  fontFamily: "sans",
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.bold),
            ),
            // FutureBuilder<void>(
            //   future: _setDataTctCategories(), // async work
            //   builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return Center(
            //           child: CircularProgressIndicator(
            //         strokeWidth: 0.8,
            //       ));
            //     } else if (snapshot.connectionState ==
            //         ConnectionState.waiting) {
            //       if (snapshot.hasError) {
            //         return Text(
            //           'Error: ${snapshot.error}',
            //           style: TextStyle(color: Colors.black, fontSize: 15),
            //         );
            //       } else if (snapshot.hasData) {
            //         return RadioButton(
            //           listDataTct: _listDataTct,
            //           callBackName: (String) {
            //             setState(() {});
            //             return nameDep = String;
            //           },
            //           callBackDep: (int) {
            //             setState(() {});
            //             return depId = int;
            //           },
            //         );
            //       }else {
            //         return const Text('Empty data');
            //       }
            //     }else {
            //       return Text('State: ${snapshot.connectionState}');
            //     }
            //   },
            // ),
            ElevatedButton(
              onPressed: () {
                if(_listDataTct.length<=0){
                  Get.snackbar(
                    'خطا',
                    'اطلاعاتی در دسترس نیست',
                    snackPosition: SnackPosition.BOTTOM,
                    forwardAnimationCurve: Curves.elasticInOut,
                    reverseAnimationCurve: Curves.easeOut,
                  );
                }else{
                  if (depId != -1) {
                    print("dep id "+depId.toString());
                    Get.find<ValueDepartmentDepId>().ValueDepId(depId);
                    widget.valueText(nameDep);
                    widget.userDepId(userDepId);
                  } else {
                    Get.find<ValueDepartmentDepId>().valueDepId.value = -1;
                  }
                  Navigator.pop(context);
                }

              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(100, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: const Text(
                'تایید',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'sans',
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    fListTctCategories = _setDataTctCategories();
    super.initState();
  }

  Future<void> _setDataTctCategories() async {
    String uRL = "";
    _listDataTct.clear();
    await Get.find<ControllerGetStorageAllData>().IsRolId == 4
        ? uRL = "${ConstString.urlSrvAccount}GetGuestLinkedCustomer?"
        : uRL = "${ConstString.urlSrvAccount}GetCustomerLinkedExperts?";
    ApiServiceListGetGuestLinkCustomer apiservice = ApiServiceListGetGuestLinkCustomer();
    apiservice
        .listTctCategories(
            uRL,
            Get.find<ControllerGetStorageAllData>().token,
            Get.find<ControllerGetStorageAllData>().userId as int,
            Get.find<ControllerGetStorageAllData>().organId ?? 1)
        .then((value) async {
      try {
        if (value.data != null && value.isSuccess == true) {
          _listDataTct.addAll(value.data!);
print("Data"+value.data!.length.toString());
          setState(() {});
        } else {
          SnackError(context, "مشکل در برقراری ارتباط با سرور");

        }
      } catch (e) {

        debugPrint(e.toString());
      }
    }).catchError((onError) {
    });
  }
}

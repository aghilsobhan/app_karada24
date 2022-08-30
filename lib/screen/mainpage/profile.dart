
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../getxController/storagedata/StrorageAllData.dart';
import '../../materialcolors/materialcolors.dart';
import '../../widgets/login/input_text_login.dart';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isHidden = true;
  String? fullName=Get.find<ControllerGetStorageAllData>().fullName??"نام و نام خانوادگی";
  String? organName=Get.find<ControllerGetStorageAllData>().organName??"نام شرکت";
  String? mobil=Get.find<ControllerGetStorageAllData>().phoneNumber??"موبایل";
  TextEditingController txtEmail= TextEditingController();
  TextEditingController txtMobil= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40,bottom: 40,right: 13,left: 13),
      child: Container(
          decoration: BoxDecoration(
            color: Palette.backGroundColorD,
            border: Border.all(color: Palette.gradient2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [

              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,

                  children: [
                   const Text("اطلاعات شخصی", style: TextStyle( fontFamily: 'sans',
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
              const CircleAvatar(
                radius: 35.0,
                backgroundImage: AssetImage(
                  'images/profile.png',
                ),
                backgroundColor: Colors.transparent,
              ),
                 Text(fullName!, style: TextStyle( fontFamily: 'sans',
                      fontSize: 13)),
                  const SizedBox(height: 20,),
                  // TextFieldCustom(
                  //   icon: Icons.person,
                  //   hint: 'ایمیل',
                  //   valueText: (String title) {
                  //    // fullname = title;
                  //   },
                  //   validatorEr: (String? valueError) {
                  //     if (valueError!.length < 4) {
                  //       return "نام و نام خانوادگی خود را وارد کنید";
                  //     } else {
                  //       return null;
                  //     }
                  //   },
                  // ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: const  Text(": اسم شرکت", style: TextStyle( fontFamily: 'sans',
                          fontSize: 12,
                          color:Palette.tickets)),
                    ),
                  ),

                  Padding(
                      padding: EdgeInsets.only(right: 10,left: 10),child: buildTextFieldEmail()),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: const  Text(": شماره موبایل", style: TextStyle( fontFamily: 'sans',
                          fontSize: 12,
                          color:Palette.tickets)),
                    ),
                  ),

                  Padding(
                      padding: EdgeInsets.only(right: 10,left: 10),child: buildTextFieldNumberPhone()),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: const  Text(": رمز عبور", style: TextStyle( fontFamily: 'sans',
                          fontSize: 12,
                          color:Palette.tickets)),
                    ),
                  ),

                  Padding(
                      padding: EdgeInsets.only(right: 10,left: 10),child: buildTextFieldPassword()),
                  SizedBox(height: 40,),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Palette.primaryColorD,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ), child:  const Text(
                    'تایید',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'sans',
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  )
            ]),
          )

      ),
    );
  }
  Widget buildTextFieldEmail() {
    txtEmail.value=TextEditingValue(text: organName.toString());

    return  Container(
      height: 60,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          controller: txtEmail,
                enabled: false,
                autocorrect: true,
                decoration: InputDecoration(
                  hintStyle:TextStyle( fontFamily: 'sans',
                    fontSize: 12,
                    color:Colors.black) ,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Palette.gradient2),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Palette.primaryColorD),
                  ),
                )
            )
        ),
    );
  }
  Widget buildTextFieldNumberPhone() {
    txtMobil.value=TextEditingValue(text: mobil.toString());
    return  Container(
      height: 60,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          controller: txtMobil,
            enabled: false,
            keyboardType: TextInputType.phone,
                autocorrect: true,
                decoration: InputDecoration(
                  hintStyle:TextStyle( fontFamily: 'sans',
                    fontSize: 12,
                    color:Colors.black) ,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Palette.gradient2),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Palette.primaryColorD),
                  ),
                )
            )
        ),
    );
  }
  Widget buildTextFieldPassword() {

    return  Container(
      height: 60,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child:  TextField(
          obscureText: _isHidden,
          enabled: false,
          decoration: InputDecoration(
            hintText: '00000000',
                      hintStyle:TextStyle( fontFamily: 'sans',
                        fontSize: 12,
                        color:Colors.black) ,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Palette.gradient2),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color:Palette.primaryColorD),
                      ),
            suffix: InkWell(
              onTap: _togglePasswordView,
              child: Icon(
                _isHidden
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
            ),
          ),
        ),
        // child: TextField(
        //   obscureText: true,
        // keyboardType: TextInputType.visiblePassword,
        //         autocorrect: true,
        //         decoration: InputDecoration(
        //           hintText: '000000',
        //
        //           hintStyle:TextStyle( fontFamily: 'sans',
        //             fontSize: 12,
        //             color:Colors.black) ,
        //           enabledBorder: UnderlineInputBorder(
        //             borderSide: BorderSide(color: Palette.gradient2),
        //           ),
        //           focusedBorder: UnderlineInputBorder(
        //             borderSide: BorderSide(color:Palette.primaryColorD),
        //           ),
        //         )
        //     )
        ),
    );
  }
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}

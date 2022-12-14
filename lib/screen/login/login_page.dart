import 'dart:async';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:app_karada24/apiService/api_service_login.dart';
import 'package:app_karada24/apiService/api_service_userInfo.dart';
import 'package:app_karada24/getxController/storagedata/StrorageAllData.dart';
import 'package:app_karada24/models/model_login.dart';
import 'package:app_karada24/screen/login/forget_password.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../Dashboard/menu_dashboard.dart';
import '../../getxController/internet/getx_network_manager.dart';
import '../../materialcolors/materialcolors.dart';
import '../../utility/snackbar_error.dart';
import '../../widgets/widget_no_internet.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKeyLogin = GlobalKey<FormState>();
  late String txtUserNameLogin;
  late String txtPasswordLogin;
  bool isLoading = false;
  bool _isObscure = true;
  final box=GetStorage();
  final GetXNetworkManager _networkManager = Get.find<GetXNetworkManager>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backGroundColorD,
      body: GetBuilder<GetXNetworkManager>(builder: (builder){
        return _networkManager.connectionType == 0?
        NoConnection():
       Scaffold(
          backgroundColor: Palette.backGroundColorD,
          body: Center(
            child: Form(
              key: formKeyLogin,
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "images/karadatext.png",
                        height: 140,
                        width: 140,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Column(
                        children: [
                         // TextFieldLoginUserName(icon:  Icons.account_circle, hint: "?????? ????????????", txtUserNameLogin: txtUserNameLogin,),
                          buildTextFieldUserNameLogin(
                              Icons.account_circle, "?????? ????????????"),
                          const SizedBox(
                            height: 10,
                          ),
                          buildTextFieldPasswordLogin(
                              Icons.lock_outline, "?????? ????????"),
                          GestureDetector(
                            onTap: () {

                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(builder: (context, setState) {
                                      return ForgetPassword();
                                    });
                                  });
                            },
                            child: Text(
                              "?????? ???????? ?????? ???? ???????????? ???????? ????????",
                              style: TextStyle(
                                  fontFamily: "sans",
                                  fontSize: 12,
                                  color: Colors.blue),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(
                              text: '???????? ?????????? ???? ?????? ',
                              style: TextStyle(
                                  fontFamily: "sans",
                                  fontSize: 12,
                                  color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  recognizer:  TapGestureRecognizer()..onTap= () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                          return LoginSignUpScreen();
                                        }));
                                  },
                                    text: ' ????????',
                                    style: TextStyle(
                                        fontFamily: "sans",
                                        fontSize: 12,
                                        color: Colors.blue),
                                      // Navigator.push(context,
                                      //     MaterialPageRoute(builder: (context) {
                                      //       return LoginSignupScreen();
                                      //     }));

                                ),
                                TextSpan(
                                    text: ' ???????? ????????',
                                    style: TextStyle(
                                        fontFamily: "sans",
                                        fontSize: 12,
                                        color: Colors.black)),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: isLoading
              ? CircularProgressIndicator()
              : FloatingActionButton.extended(
            onPressed: ()async{
              CheckUserConnection();
             // CheckUserConnection();
            },
            extendedTextStyle: TextStyle(
                fontFamily: "sansn",
                fontWeight: FontWeight.bold,
                fontSize: 12),
            label: const Text(
              '???????? ???? ??????????',
            ),
            icon: const Icon(
              Icons.login,
              size: 14,
            ),
            backgroundColor: Palette.primaryColorD,
          ),
        );
      }),
    );

  }

  Future CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          Login();
      }
    } catch (err) {
      SnackError(context,"???????? ?????????? ?????????????? ?????? ???? ?????????? ????????"+err.toString());
    }
  }
  Widget buildTextFieldUserNameLogin(IconData icon, String hint) {
    return Padding(
      padding: EdgeInsets.only(right: 25, left: 25),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        height: 70,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            maxLength: 40,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              counterText: "",
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
              labelText: hint,
              contentPadding: EdgeInsets.all(5),
              prefixIcon: Icon(
                icon,
                size: 20,
                color: Palette.primaryColorD,
              ),
              labelStyle: const TextStyle(
                  fontFamily: 'sans',
                  fontSize: 12,
                  color: Palette.primaryColorD),
            ),
            validator: (value) {
              if (value!.length < 4) {
                return "?????? ???????????? ?????? ???? ???????? ????????";
              } else {
                return null;
              }
            },
            onSaved: (value) => txtUserNameLogin = value!,
            obscureText: false,
            keyboardType: TextInputType.text,
          ),
        ),
      ),
    );
  }
  Widget buildTextFieldPasswordLogin(IconData icon, String hint) {
    return Padding(
      padding: EdgeInsets.only(right: 25, left: 25),
      child: Container(
        height: 70,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            maxLength: 40,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              counterText: "",
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
              labelText: hint,
              contentPadding: EdgeInsets.all(5),
              prefixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  child: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                    size: 20,
                    color: Palette.primaryColorD,
                  )),
              labelStyle: const TextStyle(
                  fontFamily: 'sans',
                  fontSize: 12,
                  color: Palette.primaryColorD),
            ),
            validator: (value) {
              if (value!.length < 3) {
                return "?????? ???????? ?????? ???? ???????? ????????";
              } else {
                return null;
              }
            },
            onSaved: (value) => setState(() {
              txtPasswordLogin = value!;
            }),
            obscureText: _isObscure,
            keyboardType: TextInputType.visiblePassword,
          ),
        ),
      ),
    );
  }

  Future<void> Login() async {
    isLoading = true;
    formKeyLogin.currentState!.save();
    final isValidLogin = formKeyLogin.currentState!.validate();
    if (isValidLogin) {
      ModelLogin modelLogin =
          ModelLogin(username: txtUserNameLogin.trim(), password: txtPasswordLogin.trim());

      ApiServiceLogin serviceApi = ApiServiceLogin();
      await serviceApi.number(modelLogin).then((value) async {
        if (value.isSuccess! || value.token != null) {
         await Get.find<ControllerGetStorageAllData>().saveTokens(value.token, value.refreshToken,value.userId, value.userRoleId);
         await Get.find<ControllerGetStorageAllData>().saveIsRolId(value.roleId);
          userInfo( value.userRoleId, value.token );
        } else {
          setState(() {
            isLoading = false;
          });

          Alert(
            id: "2",
            context: context,
            desc: value.userRoleId == 0
                ? "?????? ???????????? ???? ?????? ???????? ???????????? ??????"
                : value.userRoleId == -1
                    ? "?????????? ?????? ???? ?????? ?????????? ??????"
                    : "?????????? ?????? ???? ???????????? ?????????? ?????? ???????? ???? ???????????????? ???????? ????????????",
            buttons: [
              DialogButton(
                child: const Text(
                  '??????????',
                  style: TextStyle(
                      fontSize: 12, fontFamily: 'sans', color: Colors.white),
                ),
                onPressed: () {
                  Alert(context: context).dismiss();
                  setState(() {
                    isLoading = false;
                  });
                },
                color: Palette.activeColor,
              )
            ],
            style: const AlertStyle(
              isCloseButton: false,
              descStyle: TextStyle(fontFamily: 'sans', fontSize: 12),
            ),
            image: Image.asset(
              "images/warning.png",
              width: 45,
              height: 45,
            ),
          ).show();
        }
      }).catchError((e) {
        setState(() {
          isLoading = false;
        });
        SnackError(context,"???????? ???? ?????????????? ???????????? ???????? ?????????? ?????????????? ?????? ???? ???? ????????");
        print(e);
      }).onError((error, stackTrace) {
        setState(() {
          isLoading = false;
        });
        SnackError(context,error.toString());
        print(stackTrace);
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
  Future<void> userInfo(id, token) async {
    try{
    ApiServiceUserInfo apiServiceUserInfo = ApiServiceUserInfo();
      await apiServiceUserInfo.UserInfo(id, token).then((value) async {
      await Get.find<ControllerGetStorageAllData>().saveProfile(value.username, value.email, value.phoneNumber, value.fullname,value.organId,value.organName);
      await Get.find<ControllerGetStorageAllData>().readTokens();
      await Get.find<ControllerGetStorageAllData>().readProfile();
      await Get.find<ControllerGetStorageAllData>().readIsRolId();

      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  MenuDashboardT()));
    });}catch(e){
      setState(() {
        isLoading = false;
      });
      SnackError(context,"???????? ???? ?????????????? ????????????");
      print(e.toString());
    }
  }
}

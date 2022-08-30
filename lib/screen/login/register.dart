import 'package:app_karada24/apiService/api_service_register.dart';
import 'package:flutter/material.dart';
import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../models/model_register.dart';
import '../../widgets/login/input_text_login.dart';
import '../../widgets/widget_appbar.dart';
import '../../screen/login/widget_form_register.dart';

class LoginSignUpScreen extends StatefulWidget {
  const LoginSignUpScreen({Key? key}) : super(key: key);

  @override
  _LoginSignUpScreenState createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  ModelRegister modelRegister = new ModelRegister();
  final formKeyLogin = GlobalKey<FormState>();
  late String errorText = "";
  late bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'ثبت نام',
      ),
      backgroundColor: Palette.backGroundColorD,
      body: buildSignInSection(),
      floatingActionButton:isLoading?SizedBox(height: 35,width: 35,child: CircularProgressIndicator(strokeWidth: 0.6,)): FloatingActionButton.extended(
        onPressed: () async {
          Registering();
        },
        extendedTextStyle: TextStyle(
            fontFamily: "sans", fontWeight: FontWeight.bold, fontSize: 14),
        label: const Text(
          'ثبت نام',
        ),
        icon: const Icon(
          Icons.app_registration,
          size: 14,
        ),
        backgroundColor: Palette.primaryColorD,
      ),
    );
  }

  Widget buildSignInSection() {
    return SingleChildScrollView(
        child: Form(
            key: formKeyLogin,
            child: Container(
              child: Column(
                children: [
                  Image.asset(
                    "images/karadatext.png",
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFieldCustom(
                    icon: Icons.person,
                    hint: 'نام و نام خانوادگی',
                    valueText: (String title) {
                      modelRegister.fullname = title;
                    },
                    validatorEr: (String? valueError) {
                      if (valueError!.length < 4) {
                        return "نام و نام خانوادگی خود را وارد کنید";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFieldCustom(
                    icon: Icons.person_outlined,
                    hint: 'نام کاربری',
                    valueText: (String title) {
                      modelRegister.username = title;
                    },
                    validatorEr: (String? valueError) {
                      if (valueError!.length < 4) {
                        return "نام کاربری خود را وارد کنید";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFieldCustomPassword(
                    icon: Icons.visibility,
                    hint: 'رمز عبور',
                    valueText: (String title) {
                      modelRegister.password = title;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFieldCustom(
                    icon: Icons.mail_outline,
                    hint: 'ایمیل',
                    valueText: (String title) {
                      modelRegister.email = title;
                    },
                    validatorEr: (String? valueError) {
                      if (valueError!.length < 4 &&
                          modelRegister.phoneNumber == null) {
                        setState(() {
                          errorText = "شماره موبایل یا ایمیل خود را وارد کنید";
                        });
                        return " ";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFieldCustom(
                    icon: Icons.mobile_screen_share_sharp,
                    hint: 'شماره موبایل',
                    valueText: (String title) {
                      modelRegister.phoneNumber = title;
                    },
                    validatorEr: (String? valueError) {
                      if (valueError!.length < 4 && modelRegister.email == null) {
                        setState(() {
                          errorText = "شماره موبایل یا ایمیل خود را وارد کنید";
                        });
                        return " ";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    errorText.toString(),
                    style: TextStyle(
                        fontFamily: "sans", fontSize: 14, color: Colors.red),
                  ),
                  // buildTextFieldPasswordLogin(Icons.lock_outline, "رمز عبور"),
                ],
              ),
            )));
  }

  Future<void> Registering() async {
    try {

      formKeyLogin.currentState!.save();
      final isValidLogin = formKeyLogin.currentState!.validate();
      if(modelRegister.phoneNumber==null){
        modelRegister.phoneNumber="-1";
      }else{
        if(modelRegister.email==null){
          modelRegister.email=" ";
        }
      }
      modelRegister.userId=0;
      print(modelRegister.toJson());
      if (isValidLogin) {
        setState(() {
          isLoading=true;
          errorText="";
        });
        ApiServiceRegister apiServiceRegister=ApiServiceRegister();
        apiServiceRegister.register(modelRegister).then((value) {
if(value.isSuccess){
  setState(() {
    isLoading=false;
    errorText="";
  });
  Alert(
    id: "2",
    context: context,
    desc: "اطلاعات شما با موفقیت ثبت شد ",
    buttons: [
      DialogButton(
        child: const Text(
          'تایید',
          style: TextStyle(
              fontSize: 12, fontFamily: 'sans', color: Colors.white),
        ),
        onPressed: () {
          Navigator.pop(context);
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
      "images/success.png",
      width: 45,
      height: 45,
    ),
  ).show();
}else{
  if(value.errors!=null){
    Alert(
      id: "2",
      context: context,
      desc: value.errors![0].toString(),
      buttons: [
        DialogButton(
          child: const Text(
            'تایید',
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
}

        }).catchError((err){
          setState(() {
            errorText=err;
            isLoading=false;
          });

        }).onError((error, stackTrace) {
          setState(() {
            errorText="خطای نامشخص لطفا بعد از چند دقیقه دوباره تلاش کنید";
            isLoading=false;
          });
        });
      }

    } catch (e) { setState(() {
      errorText=e.toString();
      isLoading=false;
    });}


  }
}

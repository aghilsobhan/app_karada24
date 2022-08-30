
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../apiService/api_service_get_forget.dart';
import '../../materialcolors/materialcolors.dart';



class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late String txtUserNameLogin;
  bool isLoading=false;
  final formKeyLogin = GlobalKey<FormState>();
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
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  const Divider(height: 0.3,color: Palette.gradient2,),
                  Form(
                    key: formKeyLogin,
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              "images/karadatext.png",
                              height: 100,
                              width: 100,
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Text(":برای بازیابی رمز عبور نام کاربری خود را وارد کنید",style: TextStyle(
                              fontFamily: "sans",
                              fontSize: 14
                            ),),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                buildTextFieldUserNameLogin(
                                    Icons.account_circle, "نام کاربری"),
                                const SizedBox(
                                  height: 10,
                                ),
                                // RichText(
                                //   text: TextSpan(
                                //     text: 'برای عضویت از این ',
                                //     style: TextStyle(
                                //         fontFamily: "sans",
                                //         fontSize: 12,
                                //         color: Colors.black),
                                //     children: const <TextSpan>[
                                //       TextSpan(
                                //           text: ' قسمت',
                                //           style: TextStyle(
                                //               fontFamily: "sans",
                                //               fontSize: 12,
                                //               color: Colors.blue)),
                                //       TextSpan(
                                //           text: ' وارد شوید',
                                //           style: TextStyle(
                                //               fontFamily: "sans",
                                //               fontSize: 12,
                                //               color: Colors.black)),
                                //     ],
                                //   ),
                                // )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                isLoading==true?CircularProgressIndicator(strokeWidth: 0.8,):  ElevatedButton(
                    onPressed: () {
                      Login();
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
                  ),
                ]),
          )

      ),
    );
  }
  @override
  void initState() {
    super.initState();
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
                return "نام کاربری خود را وارد کنید";
              } else {
                return null;
              }
            },
            onSaved: (value) => setState(() {
              txtUserNameLogin = value!;
            }),
            obscureText: false,
            keyboardType: TextInputType.text,
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
      ApiServiceForgetPassword serviceApi = ApiServiceForgetPassword();
      await serviceApi.forgetPassword(txtUserNameLogin.trim().toString()).then((value) async {
        if (value.isSuccess!) {

          Alert(
            id: "2",
            context: context,
            desc: "رمز جدید به ایمیل شما ارسال شد",
            buttons: [
              DialogButton(
                child: const Text(
                  'تایید',
                  style: TextStyle(
                      fontSize: 12, fontFamily: 'sans', color: Colors.white),
                ),
                onPressed: () {
                  Alert(context: context).dismiss();
                  Navigator.of(context).pop();
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
        } else if (value.erorrs!=null) {
          setState(() {
            isLoading = false;
          });
          Alert(
            id: "2",
            context: context,
            desc: value.erorrs![0].toString(),
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
        }else{
          setState(() {
            isLoading = false;
          });
          Alert(
            id: "2",
            context: context,
            desc: "پیام ارسال نشد دوباره تلاش کنید",
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
      }).catchError((e) {
        setState(() {
          isLoading = false;
        });
        Get.rawSnackbar(messageText: Directionality(textDirection: TextDirection.rtl,
            child: Text("مشکل در برقراری ارتباط لطفا اتصال اینترنت خود را چک کنید",
              style: TextStyle(fontSize: 12,fontFamily: "sans",color: Colors.white),)),
          backgroundColor: Colors.red,snackPosition:SnackPosition.BOTTOM,);
        print(e);
      }).onError((error, stackTrace) {
        setState(() {
          isLoading = false;
        });
        Get.rawSnackbar(messageText: Directionality(textDirection: TextDirection.rtl,
            child: Text("مشکل در برقراری ارتباط",
              style: TextStyle(fontSize: 12,fontFamily: "sans",color: Colors.white),)),
          backgroundColor: Colors.red,snackPosition:SnackPosition.BOTTOM,);

      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
}

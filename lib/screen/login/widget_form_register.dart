
import 'package:flutter/material.dart';
import '../../models/model_register.dart';
import '../../widgets/login/input_text_login.dart';
class FormRegister extends StatefulWidget {
final Function(ModelRegister modelRegister) models;
  const FormRegister({Key? key,required this.models}) : super(key: key);

  @override
  _FormRegisterState createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  bool isSignUpScreen = false;
  bool isLoading=false;
  ModelRegister modelRegister=new ModelRegister();
  @override
  Widget build(BuildContext context) {
    return buildSignInSection();
  }
  Container buildSignInSection() {
    return Container(
      // child: Column(
      //   children: [
      //     Image.asset(
      //       "images/karadatext.png",
      //       height: 100,
      //       width: 100,
      //     ),
      //     const SizedBox(
      //       height: 30,
      //     ),
      //     TextFieldCustom(icon: Icons.person, hint: 'نام کاربری', valueText: (String title) {
      //       modelRegister.username=title;
      //     }, ),
      //     const SizedBox(
      //       height: 30,
      //     ),
      //     TextFieldCustomPassword(icon: Icons.visibility, hint: 'رمز عبور', valueText: (String title) {
      //       modelRegister.password=title;
      //     }, ),
      //     const SizedBox(
      //       height: 30,
      //     ),
      //     TextFieldCustom(icon: Icons.mail_outline, hint: 'ایمیل', valueText: (String title) {
      //       modelRegister.email=title;
      //     }, ),
      //     const SizedBox(
      //       height: 30,
      //     ),
      //     TextFieldCustom(icon: Icons.mobile_screen_share_sharp, hint: 'شماره موبایل', valueText: (String title) {
      //       modelRegister.phoneNumber=title;
      //     }, ),
      //     const SizedBox(
      //       height: 10,
      //     ),
      //     // buildTextFieldPasswordLogin(Icons.lock_outline, "رمز عبور"),
      //   ],
      // ),
    );
  }
}


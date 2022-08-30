import 'package:app_karada24/models/model_register.dart';
import 'package:flutter/material.dart';

import '../../materialcolors/materialcolors.dart';
class TextFieldCustom extends StatelessWidget {
  final IconData icon;
  final String hint;
  final String? Function(String? valueError)? validatorEr;

  final Function(String title) valueText;
  TextFieldCustom({
    required this.icon,
    required this.hint,
   required this.valueText,
   required this.validatorEr,
});
  @override
  Widget build(BuildContext context) {
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
            validator:validatorEr,
           // onSaved: (value) => txtUserNameLogin = value!

            onChanged: (value)=>valueText(value),
            obscureText: false,
            keyboardType: TextInputType.text,
          ),
        ),
      ),
    );
  }

}
class TextFieldCustomPassword extends StatefulWidget {
  final IconData icon;
  final String hint;
  final Function(String title) valueText;
  TextFieldCustomPassword({
    required this.icon,
    required this.hint,
   required this.valueText,
});

  @override
  State<TextFieldCustomPassword> createState() => _TextFieldCustomPasswordState();
}

class _TextFieldCustomPasswordState extends State<TextFieldCustomPassword> {
  bool _isObscure=true;
  @override
  Widget build(BuildContext context) {
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
                labelText: widget.hint,
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
                if (value!.length <7) {
                  return "(رمز عبور باید بیش از 8 کاراکتر باشد)رمز عبور خود را وارد کنید";
                } else {
                  return null;
                }
              },
             onChanged: (value)=>widget.valueText(value) ,
              obscureText: _isObscure,
              keyboardType: TextInputType.visiblePassword,
            ),
          ),
        ),
      );
    }
}


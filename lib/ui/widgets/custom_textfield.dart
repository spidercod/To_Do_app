import 'package:flutter/material.dart';
import 'package:todo_app/util/constants.dart';

Widget customTextField(
  BuildContext context,
  TextEditingController controller,
  String hintText,
  void Function(String) onChanged,
  bool obscureText,
) {
  return Container(
    height: kPad(context) * 0.15,
    width: kPad(context) * 0.9,
    padding: EdgeInsets.symmetric(horizontal: kPad(context) * 0.05),
    decoration: BoxDecoration(
      color: blue.withOpacity(0.1),
      borderRadius: BorderRadius.circular(7),
    ),
    child: Center(
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        cursorColor: blue,
        obscureText: obscureText,
        keyboardType: TextInputType.text,
        style:
            style(context).copyWith(fontWeight: FontWeight.w500, color: blue),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: style(context).copyWith(
                color: blue.withOpacity(0.5), fontWeight: FontWeight.w500)),
      ),
    ),
  );
}

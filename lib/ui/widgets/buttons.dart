import 'package:flutter/material.dart';
import 'package:todo_app/util/constants.dart';

IconButton numberButton(
    BuildContext context, Widget icon, void Function() onTap) {
  return IconButton(
      onPressed: onTap,
      iconSize: kPad(context) * 0.2,
      icon: Container(
        padding: EdgeInsets.all(kPad(context) * 0.07),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: dark.withOpacity(0.1),
          ),
        ),
        child: icon,
      ));
}

Widget blueButton(BuildContext context, String label, void Function() onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: kPad(context) * 0.1,
      width: kPad(context) * 0.8,
      decoration: BoxDecoration(
        color: blue,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Center(
        child: Text(
          label,
          style: style(context)
              .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
    ),
  );
}

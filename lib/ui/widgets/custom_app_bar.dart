import 'package:flutter/material.dart';
import 'package:todo_app/util/constants.dart';

Widget customAppBar(
  BuildContext context,
  String title,
  IconData firstIcon,
  IconData secondIocn,
  void Function() firstIconFunction,
  void Function() secondIconFunction,
) {
  return Container(
    height: kPad(context) * 0.25,
    width: kPad(context),
    decoration: BoxDecoration(),
    child: Center(
      child: SafeArea(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: firstIconFunction,
            icon: Icon(
              firstIcon,
              color: dark.withOpacity(0.5),
            ),
          ),
          Text(
            title,
            style: style(context).copyWith(
              fontSize: kPad(context) * 0.04,
              fontWeight: FontWeight.w400,
            ),
          ),
          IconButton(
            onPressed: secondIconFunction,
            icon: Icon(
              secondIocn,
              color: dark.withOpacity(0.5),
            ),
          ),
        ],
      )),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:todo_app/util/constants.dart';

class PopUpClass {
  final String text;
  final IconData icon;
  final Color iconColor;

  final void Function() onTap;

  PopUpClass(this.text, this.icon, this.iconColor, this.onTap);
}

bottomSheet(BuildContext context, List<PopUpClass> list) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      context: context,
      builder: (context) {
        return Container(
          height:
              (kPad(context) * 0.05 + (list.length * (kPad(context) * 0.135))),
          decoration: BoxDecoration(
              color: white2, borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: kPad(context) * 0.02))
            ],
          ),
        );
      });
}

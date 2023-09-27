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
        return Padding(
          padding: EdgeInsets.all(kPad(context) * 0.03),
          child: Container(
            height: (kPad(context) * 0.05 +
                (list.length * (kPad(context) * 0.135))),
            decoration: BoxDecoration(
                color: white2, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: kPad(context) * 0.02),
                  child: Container(
                    height: kPad(context) * 0.01,
                    width: kPad(context) * 0.1,
                    decoration: BoxDecoration(
                        color: dark.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: list.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: list[index].onTap,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: kPad(context) * 0.05,
                            top: kPad(context) * 0.04,
                            bottom: kPad(context) * 0.04),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: dark.withOpacity(
                                  index == list.length - 1 ? 0 : 0.1),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              list[index].icon,
                              color: list[index].iconColor,
                              size: kPad(context) * 0.05,
                            ),
                            SizedBox(
                              width: kPad(context) * 0.05,
                            ),
                            Text(
                              list[index].text,
                              style: style(context)
                                  .copyWith(fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ))
              ],
            ),
          ),
        );
      });
}

import 'package:ecommerce_app/views/shared/app_style.dart';
import 'package:flutter/material.dart';

class CategoryBtn extends StatelessWidget {
  final void Function()? onPress;
  final Color btnClr;
  final String label;

  const CategoryBtn(
      {super.key, this.onPress, required this.btnClr, required this.label});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width * 0.255,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: btnClr,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(9)),
        ),
        child: Center(
          child: Text(
            label,
            style: appStyle(20, btnClr, FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

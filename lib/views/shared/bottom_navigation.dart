import 'package:flutter/material.dart';

class BottomNavigationWidget extends StatelessWidget {
  final void Function()? onTap;
  final IconData? icon;

  const BottomNavigationWidget({super.key, this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 36,
        width: 36,
        child: Icon(icon, color: Colors.white,),
      ),
    );
  }
}

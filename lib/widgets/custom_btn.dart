import 'package:flutter/material.dart';
import 'package:task_management/utils/constants.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({Key? key,required this.onTap,required this.label}) : super(key: key);
  final VoidCallback onTap;
  final String label;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(pixel),
          color: primaryColor
        ),
        child: Center(child: Text(label,style: const TextStyle(color: Colors.white),)),
      ),
    );
  }
}

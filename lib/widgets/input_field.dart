import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({Key? key,required this.title,required this.hint,this.controller,this.widget}) : super(key: key);
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: pixel),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: titleStyle,),
          Container(
            height: 52,
            margin: EdgeInsets.only(top: pixel/2),
            padding: EdgeInsets.only(left: pixel),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0
              ),
              borderRadius: BorderRadius.circular(pixel)
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget== null?false:true,
                    autofocus: false,
                    cursorColor: Get.isDarkMode? Colors.grey.shade200:Colors.grey.shade700,
                    controller: controller,
                    style: subTitleStyle,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: subTitleStyle,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: context.theme.backgroundColor,width: 0)
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: context.theme.backgroundColor,width: 0)
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: widget != null,
                  child: Container(
                    child: widget,
                  ),
                )
              ],
            ),
          )
        ],

      ),
    );
  }
}

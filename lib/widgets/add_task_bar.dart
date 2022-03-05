import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTaskBar extends StatelessWidget {
  const AddTaskBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(),
    );
  }
  _appBar(BuildContext context){
    return AppBar(
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 0,
      //title: Text(widget.title),
      leading: IconButton(
        onPressed: (){

      }, icon: Icon(Get.isDarkMode? Icons.wb_sunny_outlined :Icons.nightlight_round ,size: 20),),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('assets/profile.png'),
        ),
        SizedBox(width: 20,),

      ],
    );
  }
}

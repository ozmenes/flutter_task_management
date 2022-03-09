import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotifiedPage extends StatelessWidget {
  const NotifiedPage({Key? key,required this.label}) : super(key: key);
  final String label;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SizedBox(
        child: Center(
          child: Text(label.toString().split('|')[1]),
        ),
      ),
    );
  }
  _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 10,
      centerTitle: true,
      title: Text(label.toString().split('|')[0]),
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back_ios, size: 20),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('assets/profile.png'),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}

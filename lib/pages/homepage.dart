import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../services/notify_helper.dart';
import '../services/theme_service.dart';
import '../utils/constants.dart';
import '../widgets/custom_btn.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key,required this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 var notifyHelper= NotifyHelper();
 DateTime _selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: defPadding,
        child: Column(
          children: [
            _addTaskBar(),
            SizedBox(height: pixel,),
            _addDateBar(),
            Text(_selectedDate.toString())
          ],
        ),
      ),
    );
  }
  _addDateBar(){
    return SizedBox(
        child: DatePicker(
          DateTime.now(),
          height: 100,
          width: 80,
          initialSelectedDate: DateTime.now(),
          selectionColor: primaryColor,
          selectedTextColor: Colors.white,
          dateTextStyle: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.grey),),
          dayTextStyle: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.grey),),
          monthTextStyle: GoogleFonts.lato(textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.grey),),
          onDateChange: (date){
            setState(() {
              _selectedDate=date;
            });
          },
        )
    );
  }
  _addTaskBar(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10,),
            Text(DateFormat.yMMMMd().format(DateTime.now()),style: subHeadingStyle,),
            Text("Today",style:headingStyle)
          ],
        ),
        CustomBtn(label: "+ Add Task",onTap: (){},)
      ],
    );
  }
  _appBar(){
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      elevation: 0,
      //title: Text(widget.title),
      leading: IconButton(onPressed: (){
        ThemeService().switchTheme();
        notifyHelper.displayNotification(title: "Theme",body: Get.isDarkMode?"Activated Light Theme" :"Activated Dark Theme");
        notifyHelper.scheduledNotification();
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

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:task_management/pages/add_task_bar.dart';
import 'package:task_management/widgets/tasktile.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';
import '../services/notify_helper.dart';
import '../services/theme_service.dart';
import '../utils/constants.dart';
import '../widgets/custom_btn.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notifyHelper = NotifyHelper();
  DateTime _selectedDate = DateTime.now();
  final TaskController _tasksController = Get.put(TaskController());

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    //_showTasks();
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
            SizedBox(
              height: pixel,
            ),
            _addDateBar(),
            SizedBox(
              height: pixel,
            ),
            _showTasks(),
          ],
        ),
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
          itemCount: _tasksController.taskList.length,
          itemBuilder: (context, index) {
            Task task = _tasksController.taskList[index];
            debugPrint('task ${task.toJson()}');
            if(task.repeat == 'Daily'){
              DateTime date = DateFormat.Hm().parse(task.startTime.toString());
              var _time = DateFormat.Hm().format(date);
              debugPrint('alarm $_time');
              notifyHelper.scheduledNotification(task, int.parse(_time.toString().split(':')[0]),int.parse(_time.toString().split(':')[1]));
              return Padding(
                padding: EdgeInsets.only(bottom: pixel),
                child: AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                debugPrint('tapped');
                                _showBottomSheet(
                                    context, task);
                              },
                              child: TaskTile(task),
                            ),
                          ],
                        ),
                      ),
                    )),
              );
            }
            if(task.date ==DateFormat.yMd().format(_selectedDate)){
              return Padding(
                padding: EdgeInsets.only(bottom: pixel),
                child: AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                debugPrint('tapped');
                                _showBottomSheet(
                                    context, task);
                              },
                              child: TaskTile(task),
                            ),
                          ],
                        ),
                      ),
                    )),
              );
            }else{
              return Container();
            }
          },
        );
      }),
    );
  }

  _showBottomSheet(context, Task task) {
    Get.bottomSheet(Container(
      padding: EdgeInsets.only(top: pixel / 2),
      height: task.isCompleted == 1
          ? MediaQuery.of(context).size.height * .24
          : MediaQuery.of(context).size.height * .32,
      color: Get.isDarkMode ? darHeader : Colors.white,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(pixel),
                color: Get.isDarkMode
                    ? Colors.grey.shade600
                    : Colors.grey.shade300),
          ),
          const Spacer(),
          task.isCompleted == 1
              ? Container()
              : _bottomSheetBtn(
                  label: "Task Completed",
                  onTap: (){
                    _tasksController.markTaskCompleted(task.id!);                    ;
                    Get.back();
                  },
                  color: blueColor,
                  isClose: false,
                ),
          SizedBox(
            height: pixel / 3,
          ),
          _bottomSheetBtn(
                  label: "Delete Task",
                  onTap: () {
                    _tasksController.delete(task);
                    Get.back();
                  },
                  color: Colors.red.shade300,
                  isClose: false,
                ),
          SizedBox(
            height: pixel * 1.5,
          ),
          _bottomSheetBtn(
                  label: "Close",
                  onTap: () => Get.back(),
                  color: Colors.grey.shade300,
                  isClose: true),
          SizedBox(
            height: pixel,
          ),
        ],
      ),
    ));
  }

  _bottomSheetBtn({
    required String label,
    required VoidCallback onTap,
    required Color color,
    bool isClose = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * .9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(pixel),
            color: isClose == true ? Colors.transparent : color,
            border: Border.all(
              width: 2,
              color: isClose == true
                  ? Get.isDarkMode
                      ? Colors.grey.shade600
                      : Colors.grey.shade300
                  : color,
            )),
        child: Center(
            child: Text(
          label,
          style: isClose == true
              ? titleStyle.copyWith(
                  color: Get.isDarkMode
                      ? Colors.grey.shade300
                      : Colors.grey.shade600)
              : titleStyle.copyWith(color: Colors.white),
        )),
      ),
    );
  }

  _addDateBar() {
    return SizedBox(
        child: DatePicker(
      DateTime.now(),
      height: 100,
      width: 80,
      initialSelectedDate: DateTime.now(),
      selectionColor: primaryColor,
      selectedTextColor: Colors.white,
      dateTextStyle: GoogleFonts.lato(
        textStyle: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
      ),
      dayTextStyle: GoogleFonts.lato(
        textStyle: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
      ),
      monthTextStyle: GoogleFonts.lato(
        textStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
      ),
      onDateChange: (date) {
        setState(() {
          _selectedDate = date;
        });
      },
    ));
  }

  _addTaskBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              DateFormat.yMMMMd().format(DateTime.now()),
              style: subHeadingStyle,
            ),
            Text("Today", style: headingStyle)
          ],
        ),
        CustomBtn(
          label: "+ Add Task",
          onTap: () async {
            await Get.to(() => const AddTaskBar());
            _tasksController.getTasks();
          },
        )
      ],
    );
  }

  _appBar() {
    return AppBar(
      //backgroundColor: context.theme.backgroundColor,
      elevation: 0,
      //title: Text(widget.title),
      leading: IconButton(
        onPressed: () {
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
              title: "Theme Changed",
              body: Get.isDarkMode
                  ? "Activated Light Theme"
                  : "Activated Dark Theme");
          //notifyHelper.scheduledNotification();
        },
        icon: Icon(
            Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
            size: 20),
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

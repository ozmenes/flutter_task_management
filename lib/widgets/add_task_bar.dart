import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management/controllers/task_controller.dart';
import 'package:task_management/utils/constants.dart';
import 'package:task_management/widgets/custom_btn.dart';

import '../models/task.dart';
import 'input_field.dart';

class AddTaskBar extends StatefulWidget {
  const AddTaskBar({Key? key}) : super(key: key);

  @override
  State<AddTaskBar> createState() => _AddTaskBarState();
}

class _AddTaskBarState extends State<AddTaskBar> {
  final TaskController _taskController = Get.put(TaskController());
  final _titleEditingController = TextEditingController();
  final _noteEditingController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = "23:59";
  String _startTime = DateFormat.Hm().format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = "None";
  List<String> repeatList = [
    "None",
    "Daily",
    "Weekly",
    "Monthly",
  ];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        padding: defPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                'Add Task',
                style: headingStyle,
              ),
              CustomInputField(
                title: 'Title',
                hint: 'Enter task title',
                controller: _titleEditingController,
              ),
              CustomInputField(
                title: 'Note',
                hint: 'Enter task a note',
                controller: _noteEditingController,
              ),
              CustomInputField(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: const Icon(Icons.calendar_today_outlined),
                  onPressed: () {
                    debugPrint('hi');
                    _getDateFromUser();
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: CustomInputField(
                    title: 'Start Time',
                    hint: _startTime,
                    widget: IconButton(
                      icon: const Icon(Icons.access_time_rounded),
                      onPressed: () {
                        _getTimeFromUser(isStartTime: true);
                      },
                    ),
                  )),
                  SizedBox(
                    width: pixel,
                  ),
                  Expanded(
                      child: CustomInputField(
                    title: 'End Time',
                    hint: _endTime,
                    widget: IconButton(
                      icon: const Icon(Icons.access_time_rounded),
                      onPressed: () {
                        _getTimeFromUser(isStartTime: false);
                      },
                    ),
                  )),
                ],
              ),
              CustomInputField(
                title: "Remind",
                hint: "$_selectedRemind minutes early",
                widget: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      onChanged: (String? value) {
                        setState(() {
                          _selectedRemind = int.parse(value!);
                        });
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      iconSize: 32,
                      elevation: 4,
                      style: subTitleStyle,
                      items: remindList.map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem(
                          value: value.toString(),
                          child: Text(value.toString()),
                        );
                      }).toList()),
                ),
              ),
              CustomInputField(
                title: "Repeat",
                hint: _selectedRepeat,
                widget: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      onChanged: (String? value) {
                        setState(() {
                          _selectedRepeat = value!;
                        });
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey,
                      ),
                      iconSize: 32,
                      elevation: 4,
                      style: subTitleStyle,
                      items: repeatList.map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList()),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: pixel),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _colorPalette(),
                    CustomBtn(
                        onTap: (){
                          _validateTitleAndNote();
                          //_addTaskToDB();
                        },
                        label: "Create Task")
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  _addTaskToDB()async{
    int value = await _taskController.addTask(
      task: Task(
          isCompleted: 0,
          color: _selectedColor,
          remind: _selectedRemind,
          title: _titleEditingController.text,
          note: _noteEditingController.text,
          date: DateFormat.yMd().format(_selectedDate),
          startTime: _startTime,
          endTime: _endTime,
          repeat: _selectedRepeat
      )
    );
    debugPrint("id: "+value.toString());
  }
  _validateTitleAndNote() {
    if (_titleEditingController.text.isNotEmpty &&
        _noteEditingController.text.isNotEmpty) {
      // add to db
      _addTaskToDB();
      Get.back();
    } else if (_titleEditingController.text.isEmpty ||
        _noteEditingController.text.isEmpty) {
      Get.snackbar("Required", "All fields are required.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey.shade700,
          colorText: Colors.white,
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.orangeAccent,
          ));
    }
  }

  _colorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            "Color",
            style: titleStyle,
          ),
        ),
        Wrap(
          children: List<Widget>.generate(3, (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index == 0
                      ? primaryColor
                      : index == 1
                          ? pinkColor
                          : yellowColor,
                  child: _selectedColor == index
                      ? const Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 16,
                        )
                      : Container(),
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formattedTime = pickedTime.format(context);
    if (pickedTime == null) {
      debugPrint("Time Canceled.");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formattedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formattedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1]),
        ),
        initialEntryMode: TimePickerEntryMode.input);
  }

  _getDateFromUser() async {
    DateTime? _pickedTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2050));
    if (_pickedTime != null) {
      setState(() {
        _selectedDate = _pickedTime;
        debugPrint(_selectedDate.toString());
      });
    } else {
      debugPrint('Could not picked a time');
    }
  }

  _appBar(BuildContext context) {
    return AppBar(
      //backgroundColor: Theme.of(context).backgroundColor,
      elevation: 0,
      //title: Text(widget.title),
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

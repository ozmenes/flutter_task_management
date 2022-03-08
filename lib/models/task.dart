class Task{
  int? id;
  int? isCompleted;
  int? color;
  int? remind;
  String? title;
  String? note;
  String? date;
  String? startTime;
  String? endTime;
  String? repeat;
  Task({this.id,this.isCompleted,this.color,this.remind,this.title,this.note,this.date,this.startTime,this.endTime,this.repeat});

  Task.fromJson(Map<String,dynamic>json){
    id = json['id'];
    isCompleted = json['isCompleted'];
    color = json['color'];
    remind = json['remind'];
    title = json['title'];
    note = json['note'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    repeat = json['repeat'];
  }
  Map<String,dynamic>toJson(){
    final Map<String,dynamic> data = <String,dynamic>{};
    data['id'] = id;
    data['isCompleted'] = isCompleted;
    data['color'] = color;
    data['remind'] = remind;
    data['title'] = title;
    data['note'] = note;
    data['date'] = date;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['repeat'] = repeat;

    return data;
  }
}
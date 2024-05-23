class TaskData {
  final int? id;
  String? title;
  TaskData({this.title, this.id,});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title};
  }
}

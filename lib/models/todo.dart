class ToDo {
  String id;
  String task;
  bool isCompleted;

  ToDo({required this.id, required this.task, this.isCompleted = false});

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['id'],
      task: json['task'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task': task,
      'isCompleted': isCompleted,
    };
  }
}

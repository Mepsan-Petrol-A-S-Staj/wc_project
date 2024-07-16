class Task {
  final int id, frequency;
  final String name, createTime, updateTime;
  final bool deleted;
  final String? deleteTime;

  Task({
    required this.id,
    required this.name,
    required this.frequency,
    required this.createTime,
    required this.updateTime,
    required this.deleted,
    this.deleteTime,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['task']['name'],
      frequency: json['task']['frequency'],
      createTime: json['task']['createTime'],
      updateTime: json['task']['updateTime'],
      deleted: json['task']['deleted'],
      deleteTime: json['task']['deleteTime'],
    );
  }
}

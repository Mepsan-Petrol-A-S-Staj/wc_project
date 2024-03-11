class Task {
  final String name;
  final String frequency;

  Task({
    required this.name,
    required this.frequency,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      name: json['name'],
      frequency: json['frequency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'frequency': frequency,
    };
  }
}
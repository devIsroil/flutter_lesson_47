class Todo {
  final String todoId;
  String todoTitle;
  String todoDescription;
  final String todoCreatedDate;
  bool isDone;

  Todo({
    required this.todoId,
    required this.todoTitle,
    required this.todoDescription,
    required this.todoCreatedDate,
    required this.isDone,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      todoId: json['id'],
      todoTitle: json['title'],
      todoDescription: json['description'],
      todoCreatedDate: json['createdDate'],
      isDone: json['isDone'] == 'true' || json['isDone'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': todoId,
      'title': todoTitle,
      'description': todoDescription,
      'createdDate': todoCreatedDate,
      'isDone': isDone,
    };
  }
}
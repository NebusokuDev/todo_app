class Todo {
  final int? id;
  final String title;
  final String detail;
  final bool isComplete;

  Todo({
    this.id,
    required this.title,
    required this.detail,
    required this.isComplete,
  });

  Todo copyWith({int? id, String? title, String? detail, bool? isComplete}) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "detail": detail,
      "isComplete": isComplete ? 1 : 0 // true: 1 / false: 0
    };
  }

  Todo.fromMap(Map<String, dynamic> map)
      : id = map["id"] as int,
        title = map["title"] as String,
        detail = map["detail"] as String,
        isComplete = map["isComplete"] as int == 1;
}

class Todo {
  final String id;
  final String title;
  final String detail;
  final bool isComplete;

  const Todo({
    required this.id,
    required this.title,
    required this.detail,
    required this.isComplete,
  });

  Todo copyWith({String? id, String? title, String? detail, bool? isComplete}) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  dynamic toJson() {
    return {
      "id": id,
      "title": title,
      "detail": detail,
      "isComplete": isComplete
    };
  }

  Todo fromJson(Map<String, dynamic> json) {
    return Todo(id: id, title: title, detail: detail, isComplete: isComplete);
  }
}

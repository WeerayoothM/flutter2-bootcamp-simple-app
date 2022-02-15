class Todo {
  String title;
  String detail;
  int id;

  Todo({required this.title, required this.detail, required this.id});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(title: json['title'], detail: json['detail'], id: json['id']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['detail'] = this.detail;
    data['id'] = this.id;
    return data;
  }
}

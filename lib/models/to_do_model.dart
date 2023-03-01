class ToDoModel {
  final int? id;
  final String? name;
  final String? description;

  ToDoModel({required this.id, required this.name, required this.description});

  ToDoModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        name = res['name'],
        description = res['description'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}

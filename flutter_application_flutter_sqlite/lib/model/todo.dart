class Todo{
  final int id;
  final String title;
  final String description;
  Todo({
    required this.id,
    required this.title,
    required this.description
  });

  factory Todo.fromSqfliteDatabase(Map<String, dynamic> map)=>Todo(
    id: map['id']?.toInt() ?? 0,
    title: map['title']?.toString() ?? '',
    description: map['description']?.toString() ?? '' 
  );
   
  

}
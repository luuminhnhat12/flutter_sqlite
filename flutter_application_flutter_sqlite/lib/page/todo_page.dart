
import 'package:flutter/material.dart';
import 'package:flutter_application_flutter_sqlite/model/todo.dart';
import 'package:flutter_application_flutter_sqlite/services/todo_db.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  Future<List<Todo>>? _todoList;
  final todoDB = TodoDB();
  @override
  void initState() {
    super.initState();
    fetchAllTodo();
  }
  void fetchAllTodo(){
    setState(() {
      _todoList = todoDB.fetchAll();
    });
  }

  @override
  Widget build(BuildContext context) {

    return const Placeholder();
  }
}
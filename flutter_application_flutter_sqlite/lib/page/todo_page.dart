
import 'package:flutter/material.dart';
import 'package:flutter_application_flutter_sqlite/model/todo.dart';
import 'package:flutter_application_flutter_sqlite/services/database_service.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Todo>>(
        future: _todoList,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(snapshot.data![index].title, style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w400),),
                  subtitle: Text(snapshot.data![index].description),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: (){
                      DatabaseService().delete(id: snapshot.data![index].id);
                      fetchAllTodo();
                    },
                  ),
                );
              },
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else{
            return const Center(
              child: Text("Empty List"),
            );
          }
          
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: ((context) {
            TextEditingController titleController = TextEditingController();
            TextEditingController descriptionController = TextEditingController();
            return AlertDialog(
              title: const Text('Add Todo'),
              content: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      hintText: 'Title'
                    ),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      hintText: 'Description'
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    todoDB.insert(
                      title: titleController.text,
                      description: descriptionController.text
                    );
                    fetchAllTodo();
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          }));
        },
        child:const Icon(Icons.add),
      ),
    );
  }
}
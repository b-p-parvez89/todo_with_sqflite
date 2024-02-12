import 'package:flutter/material.dart';
import 'package:todo_with_sqflite/database/todo_repository.dart';
import 'package:todo_with_sqflite/model/db_model.dart';
import 'package:todo_with_sqflite/screen/addTodo.dart';

class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen({super.key});

  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {

  final TodoRepository todoRepository=TodoRepository();
  late Future <List<Todo>> todo;

  @override
  void initState() {
    
    super.initState();
    refreshTodos();
  }
  void refreshTodos(){
    setState((){
      todo=todoRepository.getAllTodo();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Todo"),),
      body:FutureBuilder<List<Todo>>(
        future: todo,
        
        builder: (context, snapshot) {
        
      if (snapshot.hasData) {
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context , index){
            final todo=snapshot.data![index];
          return ListTile(
            title: Text(todo.title),
            subtitle: Text(todo.description),
            trailing: Checkbox(value: todo.isDone, 
            onChanged: (bool? newValue){
              todoRepository.updateTodo(todo);
              refreshTodos();
            },
            ),
            onLongPress: () {
              todoRepository.deleteTodo(todo.id!);
            },
          );
        });
      } else if(snapshot.hasError){
        return Text("Error ${snapshot.error}");
      }else{
        return Center(child: CircularProgressIndicator(),);
      }
      },),

      floatingActionButton: FloatingActionButton(onPressed: (){

        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTodo()),).then((value) => refreshTodos());
      },
      tooltip: 'AddTodo'
      ,child: Icon(Icons.add),
      ),
    );
  }
}
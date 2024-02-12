import 'package:flutter/material.dart';
import 'package:todo_with_sqflite/database/todo_repository.dart';
import 'package:todo_with_sqflite/model/db_model.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
 final  TextEditingController titleController=TextEditingController();
final  TextEditingController descriptionController=TextEditingController();
final TodoRepository todoRepository=TodoRepository(); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Todo"),),
      body: Padding(padding: EdgeInsets.all(16),
      child: Column(children: [
        TextField(
          controller: titleController,
          decoration: InputDecoration(hintText: "Title", border: OutlineInputBorder()),
        ),
        SizedBox(height: 10,),
        TextField(controller: descriptionController,
        decoration: InputDecoration(hintText: "Description", border: OutlineInputBorder()),
        ),
        SizedBox(height: 20,),
        ElevatedButton(onPressed: ()async{
           if(titleController.text.isNotEmpty&& descriptionController.text.isNotEmpty){
            await todoRepository.insertTodo(Todo(title: titleController.text, description: descriptionController.text));
            Navigator.pop(context);
           }else{
        SnackBar(content: Text("Fill all TextField"));
           }
        }, child: Text("Add Todo"))
      ]),
      ),
    );
  }
}
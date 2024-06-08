import 'package:flutter/material.dart';
import 'package:todo_app/TodoModel.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  TextEditingController taskTeController = TextEditingController();
  List<TodoModel> todoList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Todo App'),
        ),
        body: Stack(
          children: [
            Positioned.fill(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'My Todos',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: todoList.length,
                    itemBuilder: (context, i) {
                      return _buildData(todoList[i], i);
                    },
                  ),
                )
              ],
            )),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.10,
                  width: double.maxFinite,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                            controller: taskTeController,
                            decoration: InputDecoration(
                                hintText: 'Add A New Task',
                                border: OutlineInputBorder()),
                          )),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.20,
                              child: Container(
                                  height: 60,
                                  width: 60,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        if (taskTeController.text == null ||
                                            taskTeController.text.trim() ==
                                                " ") {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Fill up the text feild')));
                                        } else {
                                          todoList.add(TodoModel(
                                              taskName: taskTeController.text));
                                          taskTeController.clear();
                                          setState(() {});
                                        }
                                      },
                                      child: Icon(Icons.add))),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        ));
  }

  Widget _buildData(TodoModel todo, int i) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Card(
        elevation: 3,
        color: todo.isDone? Colors.red : Colors.amber,
        child: ListTile(
          leading: todo.isDone
              ? InkWell(
              onTap: (){
                todo.isDone = false;
                setState(() {});
              },
              child: Icon(Icons.check_box))
              : InkWell(
              onTap: (){
                todo.isDone = true;
                setState(() {});
              },
              child: Icon(Icons.check_box_outline_blank)),
          title: Text(
            '${todo.taskName}',
            style: TextStyle(
              fontSize: 18,
              // color: todo.isDone? Colors.red : Colors.blue,
            ),
          ),
          trailing: IconButton(
              onPressed: () {
                todoList.removeAt(i);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Task Deleted')));
                setState(() {});
              },
              icon: Icon(Icons.delete)),
        ),
      ),
    );
  }
}

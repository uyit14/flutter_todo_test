import 'package:flutter/material.dart';
import 'package:flutter_todo_test/ui/common/config.dart';

class NewTodo extends StatefulWidget {
  final Function onCreateTodo;

  NewTodo(this.onCreateTodo);

  @override
  _NewTodoState createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final titleController = TextEditingController();

  final contentController = TextEditingController();

  void onSubmitData() {
    final title = titleController.text;
    final content = contentController.text;
    if (title.isEmpty && content.isEmpty) {
      return;
    }
    widget.onCreateTodo(title, content);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => onSubmitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Content'),
              controller: contentController,
              onSubmitted: (_) => onSubmitData(),
            ),
            SizedBox(height: 6),
            FlatButton(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('Add todo', style: AppTextStyle.content),
              onPressed: onSubmitData,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_todo_test/models/todo.dart';
import 'package:flutter_todo_test/ui/common/config.dart';

class DetailDialogWidget extends StatelessWidget {
  final Todo todo;

  DetailDialogWidget(this.todo);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: Text(todo.title, style: AppTextStyle.title)),
                Icon(
                  todo.isComplete ? Icons.archive : Icons.unarchive,
                  color: todo.isComplete ? Colors.green : Colors.red,
                )
              ],
            ),
            SizedBox(height: 8),
            Text(todo.content, style: AppTextStyle.content),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_todo_test/models/todo.dart';
import 'package:flutter_todo_test/ui/common/config.dart';

import 'detail_dialog_widget.dart';

class TodoItemWidget extends StatefulWidget {
  final Todo todo;
  final Key key;
  final Function onChangeStatus;
  final Function onDeleteTodo;

  TodoItemWidget(
      {@required this.todo,
      @required this.key,
      @required this.onChangeStatus,
      @required this.onDeleteTodo});

  @override
  _TodoItemWidgetState createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends State<TodoItemWidget> {
  bool isComplete;

  @override
  void initState() {
    isComplete = widget.todo.isComplete;
    super.initState();
  }

  @override
  void didUpdateWidget(TodoItemWidget oldWidget) {
    if (oldWidget != widget)
      setState(() {
        isComplete = widget.todo.isComplete;
      });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (_) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: GestureDetector(
                  child: DetailDialogWidget(widget.todo),
                  onTap: () {},
                  behavior: HitTestBehavior.opaque),
            );
          },
        );
      },
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: widget.onDeleteTodo,
          ),
        ],
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.todo.title,
                        style: AppTextStyle.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    SizedBox(height: 6),
                    Text(widget.todo.content,
                        style: AppTextStyle.content,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis)
                  ],
                ),
              ),
              IconButton(
                icon: Icon(isComplete ? Icons.archive : Icons.unarchive),
                color: isComplete ? Colors.green : Colors.red,
                onPressed: () {
                  setState(() {
                    isComplete = widget.todo.isComplete;
                  });
                  widget.onChangeStatus();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

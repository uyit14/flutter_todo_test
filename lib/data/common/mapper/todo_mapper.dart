import 'package:flutter_todo_test/data/common/models/todo_model.dart';
import 'package:flutter_todo_test/models/todo.dart';

class TodoMapper {
  static Todo toTodoEntity(TodoModel todoModel) {
    return Todo(
        id: todoModel.id,
        title: todoModel.title,
        content: todoModel.content,
        isComplete: todoModel.isComplete != 0 ? true : false);
  }

  static TodoModel toTodoModel(Todo todo) {
    return TodoModel(
        id: todo.id,
        title: todo.title,
        content: todo.content,
        isComplete: todo.isComplete ? 1 : 0);
  }

  static List<Todo> toTodoEntityList(List<TodoModel> todoModelList) {
    List<Todo> todoEntityList = List();
    todoModelList.forEach((todoModel) {
      todoEntityList.add(toTodoEntity(todoModel));
    });
    return todoEntityList;
  }
}



import 'package:flutter_todo_test/data/common/db/db_provider.dart';
import 'package:flutter_todo_test/data/common/mapper/todo_mapper.dart';
import 'package:flutter_todo_test/models/todo.dart';

import 'home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<bool> createTodo(Todo todo) async {
    final result = await DBProvider().insertTodo(TodoMapper.toTodoModel(todo));
    return result != 0;
  }

  @override
  Future<bool> deleteTodo(int id) async {
    final result = await DBProvider().deleteTodo(id);
    return result != 0;
  }

  @override
  Future<List<Todo>> getTodoList() async {
    final result = await DBProvider().getTodoList();
    return TodoMapper.toTodoEntityList(result);
  }

  @override
  Future<bool> updateTodo(Todo todo) async {
    final result = await DBProvider().updateTodo(TodoMapper.toTodoModel(todo));
    return result != 0;
  }

  @override
  Future<List<Todo>> getCompleteTodoList() async {
    final result = await DBProvider().getCompleteTodoList();
    return TodoMapper.toTodoEntityList(result);
  }

  @override
  Future<List<Todo>> getInCompleteTodoList() async {
    final result = await DBProvider().getInCompleteTodoList();
    return TodoMapper.toTodoEntityList(result);
  }
}

import 'package:flutter_todo_test/models/todo.dart';

abstract class HomeRepository{
  Future<List<Todo>> getTodoList();
  Future<List<Todo>> getCompleteTodoList();
  Future<List<Todo>> getInCompleteTodoList();
  Future<bool> createTodo(Todo todo);
  Future<bool> deleteTodo(int id);
  Future<bool> updateTodo(Todo todo);
}
import 'package:flutter/foundation.dart';

class Todo {
  final int id;
  final String title;
  final String content;
  final bool isComplete;

  Todo(
      {this.id,
      @required this.title,
      @required this.content,
      @required this.isComplete});
}

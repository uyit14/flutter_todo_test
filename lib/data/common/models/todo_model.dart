import 'package:flutter_todo_test/data/common/db/db_provider.dart';

class TodoModel{
   int id;
   String title;
   String content;
   int isComplete;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DBProvider.COLUMN_TITLE: title,
      DBProvider.COLUMN_CONTENT: content,
      DBProvider.COLUMN_COMPLETE: isComplete
    };
    if (id != null) {
      map[DBProvider.COLUMN_ID] = id;
    }
    return map;
  }

   TodoModel({this.id, this.title, this.content, this.isComplete});

   TodoModel.fromMap(Map<String, dynamic> map) {
    id = map[DBProvider.COLUMN_ID];
    title = map[DBProvider.COLUMN_TITLE];
    content = map[DBProvider.COLUMN_CONTENT];
    isComplete = map[DBProvider.COLUMN_COMPLETE];
  }
}

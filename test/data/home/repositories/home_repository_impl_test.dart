import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_test/data/home/repositories/home_repository_impl.dart';
import 'package:flutter_todo_test/models/todo.dart';

//run "flutter run test/data/home/repositories/home_repository_impl_test.dart" for test
main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  HomeRepositoryImpl homeRepositoryImpl;

  setUp(() async {
    homeRepositoryImpl = HomeRepositoryImpl();
  });

  group("local db test", () {
    //insert
    test("should insert todo success", () async {
      final todo =
          Todo(title: "Title 1", content: "Content 1", isComplete: false);
      final result = await homeRepositoryImpl.createTodo(todo);
      expect(result, true);
    });
    //list all
    test("should return todo list", () async {
      final result = await homeRepositoryImpl.getTodoList();
      expect(result.length, 4);
    });
    //complete
    test("should return complete todo list", () async {
      final result = await homeRepositoryImpl.getCompleteTodoList();
      expect(result.length, 0);
    });
    //incomplete
    test("should return incomplete todo list", () async {
      final result = await homeRepositoryImpl.getInCompleteTodoList();
      expect(result.length, 4);
    });
  });
}

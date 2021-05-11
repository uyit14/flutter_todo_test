import 'package:flutter/material.dart';
import 'package:flutter_todo_test/models/todo.dart';
import 'package:flutter_todo_test/ui/home/blocs/home_bloc.dart';
import 'package:flutter_todo_test/ui/home/widgets/new_todo_widget.dart';
import 'package:provider/provider.dart';

import 'all_todo_page.dart';
import 'complete_todo_page.dart';
import 'incomplete_todo_page.dart';

class HomePage extends StatefulWidget {
  final HomeBloc _homeBloc;

  const HomePage({@required HomeBloc homeBloc}) : _homeBloc = homeBloc;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, Object>> _pages = [
    {'page': AllTodoPage(), 'title': 'All todo'},
    {'page': CompleteTodoPage(), 'title': 'Completed todo'},
    {'page': InCompleteTodoPage(), 'title': 'Incomplete todo'}
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _onCreateTodo(String title, String content) async {
    final todo = Todo(title: title, content: content, isComplete: false);
    final result = await widget._homeBloc.requestInsertTodo(todo);
    if (result) {
      widget._homeBloc.requestGetTodoList();
    }
  }

  void _openAddNewTodo(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      builder: (_) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: GestureDetector(
              child: NewTodo(_onCreateTodo),
              onTap: () {},
              behavior: HitTestBehavior.opaque),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Provider<HomeBloc>(
      create: (context) => widget._homeBloc,
      dispose: (context, bloc) => widget._homeBloc.dispose(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectedPageIndex]['title']),
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  _openAddNewTodo(context);
                },
                icon: Icon(
                  Icons.note_add,
                  size: 40,
                ),
                label: Text(""))
          ],
        ),
        body: _pages[_selectedPageIndex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.white,
          currentIndex: _selectedPageIndex,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.format_align_left, size: 26),
                label: 'All'),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.archive, size: 26),
                label: 'Complete'),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.unarchive, size: 26),
                label: 'InComplete'),
          ],
        ),
      ),
    );
  }
}

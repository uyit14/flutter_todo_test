import 'package:flutter/material.dart';

import 'di/injection_container.dart' as di;
import 'ui/home/pages/home_page.dart';

void main() async {
  await di.init();
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(homeBloc: di.sl()),
    );
  }
}

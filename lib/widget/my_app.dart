import 'package:app_tarefa/view/my_home_page.dart';
import 'package:app_tarefa/view/toDoList/to_do_list_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String pageToDoList = 'todolist';
  static const String pagehome = '/';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(),
      routes: {
        pageToDoList: (context) => const ToDoListPage(),
      },
    );
  }
}

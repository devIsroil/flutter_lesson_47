import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/todo_model.dart';


class TodoHttpService {
  Future<List<Todo>> getTodos() async {
    final Uri url =
        Uri.parse('https://lesson46-7e4d7-default-rtdb.firebaseio.com/.json');
    final http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data == null) {
        return [];
      }
      List<Todo> loadedTodos = [];

      data.forEach((key, value) {
        value['id'] = key;
        loadedTodos.add(Todo.fromJson(value));
      });

      return loadedTodos;
    } else {
      throw Exception('error: TodoHttpService().getTodos');
    }
  }

  Future<Todo> addTodo({
    required String todoTitle,
    required String todoDescription,
  }) async {
    Map<String, dynamic> todoData = {
      'title': todoTitle,
      'description': todoDescription,
      'created-date': DateTime.now().toString(),
      'is-done': false,
    };
    final Uri url =
    Uri.parse('https://lesson46-7e4d7-default-rtdb.firebaseio.com/.json');
    final response = await http.post(
      url,
      body: jsonEncode(todoData),
    );
    final data = jsonDecode(response.body);
    todoData['id'] = data['name'];
    Todo newTodo = Todo.fromJson(todoData);
    return newTodo;
  }

  Future<void> toggleTodo(
      {required String todoId, required bool todoStatus}) async {
    final Uri url = Uri.parse(
        'https://lesson46-7e4d7-default-rtdb.firebaseio.com/$todoId.json');
    Map<String, dynamic> todoData = {'isDone': todoStatus};
    final http.Response response = await http.patch(
      url,
      body: jsonEncode(todoData),
    );
    //print(response.body);
  }

  Future<void> deleteTodo({required String todoId}) async {
    final Uri url = Uri.parse(
        'https://lesson46-7e4d7-default-rtdb.firebaseio.com/$todoId.json');
    await http.delete(url);
  }

  Future<void> editTodo({
    required String todoId,
    required String newTodoTitle,
    required String newTodoDescription,
  }) async {
    final Uri url = Uri.parse(
        'https://lesson46-7e4d7-default-rtdb.firebaseio.com/$todoId.json');
    Map<String, dynamic> todoData = {
      'title': newTodoTitle,
      'description': newTodoDescription,
    };

    await http.patch(
      url,
      body: jsonEncode(todoData),
    );
  }
}
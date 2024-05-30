


import '../models/todo_model.dart';
import '../services/todo_http_service.dart';

class TodoRepository {
  final TodoHttpService _todoHttpService = TodoHttpService();

  Future<List<Todo>> getTodosRepo() async {
    return _todoHttpService.getTodos();
  }

  Future<Todo> addTodoRepo({
    required String todoTitle,
    required String todoDescription,
  }) async {
    return await _todoHttpService.addTodo(
      todoTitle: todoTitle,
      todoDescription: todoDescription,
    );
  }

  Future<void> toggleTodoRepo(
      {required String todoId, required bool todoStatus}) async {
    await _todoHttpService.toggleTodo(todoId: todoId, todoStatus: todoStatus);
  }

  Future<void> deleteTodoRepo({required String todoId}) async {
    await _todoHttpService.deleteTodo(todoId: todoId);
  }

  Future<void> editTodoRepo({
    required String todoId,
    required String newTodoTitle,
    required String newTodoDescription,
  }) async {
    await _todoHttpService.editTodo(
      todoId: todoId,
      newTodoTitle: newTodoTitle,
      newTodoDescription: newTodoDescription,
    );
  }
}


import '../models/todo_model.dart';
import '../repositories/todo_repository.dart';

class TodoViewModel {
  final TodoRepository _todoRepository = TodoRepository();

  List<Todo> _todosList = [];

  Future<List<Todo>> get todoList async {
    _todosList = await _todoRepository.getTodosRepo();
    return [..._todosList];
  }

  Future<void> addTodo(
      {required String todoTitle, required String todoDescription}) async {
    final Todo newTodo = await _todoRepository.addTodoRepo(
      todoTitle: todoTitle,
      todoDescription: todoDescription,
    );
    _todosList.add(newTodo);
  }

  Future<void> toggleTodo(
      {required String todoId, required bool todoStatus}) async {
    await _todoRepository.toggleTodoRepo(
        todoId: todoId, todoStatus: todoStatus);
    final int index = _todosList.indexWhere((todo) {
      return todo.todoId == todoId;
    });
    _todosList[index].isDone = !_todosList[index].isDone;
  }

  Future<void> deleteProduct({required String todoId}) async {
    await _todoRepository.deleteTodoRepo(todoId: todoId);
    _todosList.removeWhere((Todo todo) => todo.todoId == todoId);
  }

  Future<void> editTodo({
    required String todoId,
    required String newTodoTitle,
    required String newTodoDescription,
  }) async {
    await _todoRepository.editTodoRepo(
      todoId: todoId,
      newTodoTitle: newTodoTitle,
      newTodoDescription: newTodoDescription,
    );

    final int index =
    _todosList.indexWhere((Todo todo) => todo.todoId == todoId);

    _todosList[index].todoTitle = newTodoTitle;
    _todosList[index].todoDescription = newTodoDescription;
  }
}
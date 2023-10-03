import 'package:amplify_flutter/amplify_flutter.dart';

import 'models/Todo.dart';

class TodoRepository {

  Stream observeTodos() {
    return Amplify.DataStore.observe(Todo.classType);
  }

  Future<List<Todo>> getTodos() async {
    try {
      final todos = await Amplify.DataStore.query(Todo.classType);
      return todos;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createTodo(String title) async {
    final newTodo = Todo(title: title, isComplete: false);
    try {
      await Amplify.DataStore.save(newTodo);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTodoIsComplete(Todo todo, bool isComplete) async {
    final updatedTodo = todo.copyWith(isComplete: isComplete);
    try {
      await Amplify.DataStore.save(updatedTodo);
    } catch (e) {
      rethrow;
    }
  }
  Future<void> deletToDo(Todo todo) async {
    try {
      await Amplify.DataStore.delete(todo);
    } catch (e) {
      rethrow;
    }
  }
}

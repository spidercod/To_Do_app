import 'package:hive/hive.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/ui/widgets/taost_notification.dart';

class TodoRepository {
  late Box<TodoMOdel> _todo;

  //This function is to initiate the hive  database and create/ open the box for todo models...
  Future<void> init() async {
    Hive.registerAdapter(TodoMOdelAdapter());
    _todo = await Hive.openBox<TodoMOdel>('todo_box');
  }

  //to get the todolist according t the codee
  List<TodoMOdel> getTodos(final int code) { 
    final todos = _todo.values.where((element) => element.code == code);
    return todos.toList();
  }


//to add the task to the list according to the respective code...
  void addTodos(final int code, final int animationIndex, final String task,
      final int time, final int statusIndex) {
    _todo
        .add(TodoMOdel(code, animationIndex, task, time, statusIndex))
        .whenComplete(() => showTaost('$task added successfully!'));
  }

//to update the task status(if it is completed/ working on it/not completed)
  Future<void> removeTodos(final int code, final String task) async {
    final taskToRemove = _todo.values
        .firstWhere((element) => element.code == code && element.task == task);
    await taskToRemove
        .delete()
        .whenComplete(() => showTaost('$task removed successfully!'));
  }

  //To update the task status(if it is completd/working on it/ not completed)
  Future<void> updateTodos(final int code, final String task,
      final int animationIndex, final int time, final int statusIndex) async {
    final taskToEdit = _todo.values
        .firstWhere((element) => element.code == code && element.task == task);

    //it will provide a particular key for that  particular task...

    final index = taskToEdit.key as int;

    await _todo
        .put(index, TodoMOdel(code, animationIndex, task, time, statusIndex))
        .whenComplete(() => showTaost('$task updated successfully!'));
  }
}

part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  final int index;
  const TodoState(this.index);

  @override
  List<Object> get props => [index];
}

class TodoInitial extends TodoState {
  final int index;

  const TodoInitial(this.index) : super(0);

  @override
  List<Object> get props => [index];
}

class AnimationdGridState extends TodoState {
  const AnimationdGridState(super.index);
}

// to load the todo list according to the code entered
class LoadedTodoListState extends TodoState {
  final int code;
  final List<TodoMOdel> todos;

  const LoadedTodoListState(super.index, this.code, this.todos);
  @override
  List<Object> get props => [code, todos];
}

class PopState extends TodoState {
  const PopState(super.index);
}
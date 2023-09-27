import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/repositories/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _tdoRepository;

  TodoBloc(this._tdoRepository) : super(const TodoInitial(0)) {
    //* add to the bloc...
    on<AddTodoEvent>((event, emit) {
      _tdoRepository.addTodos(event.code, event.animationIndex, event.task,
          DateTime.now().millisecondsSinceEpoch, 0);
      emit(const PopState(0));
    });

    on<AnimatedButtonClickedEvent>((event, emit) {
      emit(const AnimationdGridState(0));
    });

    on<AnimatedSelectedEvent>((event, emit) {
      emit(TodoInitial(event.index));
    });

//load todo bloc

    on<LoadTodoListEvent>((event, emit) async {
      final todos = _tdoRepository.getTodos(event.code);
      emit(LoadedTodoListState(0, event.code, todos));
    });

//mark done BlocBuuilder

    on<MarkDoneEvent>((event, emit) async {
      await _tdoRepository.updateTodos(event.code, event.task as int,
          event.animationIndex as String, event.time, event.statusIndex);
      add(LoadTodoListEvent(event.code));

      emit(const PopState(0));
    });

    on<DeleteTaskEvent>((event, emit) async {
      await _tdoRepository.removeTodos(event.code, event.task);
      add(LoadTodoListEvent(event.code));

      emit(const PopState(0));
    });
  }
}

import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 2)
class TodoMOdel extends HiveObject {
  @HiveField(0)
  final int code;
  @HiveField(1)
  final int animationIndex;
  @HiveField(2)
  final String task;
  @HiveField(3)
  final int time;
  @HiveField(4)
  final int statusIndex;

  TodoMOdel(
      this.code, this.animationIndex, this.task, this.time, this.statusIndex);
}

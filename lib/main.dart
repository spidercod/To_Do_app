import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/bloc/Lock/lock_bloc.dart';
import 'package:todo_app/repositories/todo_repository.dart';
import 'package:todo_app/ui/lock_screen.dart';
import 'package:todo_app/util/constants.dart';

import 'repositories/lock_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => LockRepository()),
        RepositoryProvider(create: (context) => TodoRepository()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: theme(),
        home: BlocProvider(
          create: (context) => LockBloc(
            RepositoryProvider.of<LockRepository>(context),
            RepositoryProvider.of<TodoRepository>(context),
          )..add(HiveBoxOpeningEvent()),
          child: const LockScreen(),
        ),
      ),
    );
  }
}

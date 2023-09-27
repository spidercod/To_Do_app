import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/bloc/Lock/lock_bloc.dart';
import 'package:todo_app/bloc/todo/bloc/todo_bloc.dart';
import 'package:todo_app/repositories/lock_repository.dart';
import 'package:todo_app/repositories/todo_repository.dart';
import 'package:todo_app/ui/add_todo_screen.dart';
import 'package:todo_app/ui/widgets/custom_app_bar.dart';
import 'package:todo_app/ui/widgets/fullscreen_bottomsheet.dart';
import 'package:todo_app/util/constants.dart';
import 'package:todo_app/util/navigator.dart';

class TodoScreen extends StatelessWidget {
  final int code;
  const TodoScreen({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: kPad(context),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: kPad(context) * 0.2,
                ),
                BlocConsumer<TodoBloc, TodoState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is LoadedTodoListState) {
                      return ListView(
                        children: [
                          ...state.todos.map((e) => Container(
                                padding: EdgeInsets.all(kPad(context) * 0.05),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: dark.withOpacity(0.1)),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: kPad(context) * .3,
                                      width: kPad(context) * .3,
                                      child: Lottie.asset(
                                          'assets//json/${e.animationIndex}.json',
                                          repeat: true,
                                          reverse: true),
                                    )
                                  ],
                                ),
                              ))
                        ],
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: customAppBar(
                context, 'All Tasks', CupertinoIcons.left_chevron, Iconsax.add,
                () {
              replace(
                  context,
                  BlocProvider(
                    create: (context) => LockBloc(
                      RepositoryProvider.of<LockRepository>(context),
                      RepositoryProvider.of<TodoRepository>(context),
                    )..add(HiveBoxOpeningEvent()),
                  ));
            }, () {
              fullScreenBottomSheet(
                  context,
                  BlocProvider(
                    create: (context) => TodoBloc(
                        RepositoryProvider.of<TodoRepository>(context)),
                    child: AddTodoScreen(
                      code: code,
                    ),
                  ));
            }))
      ],
    ));
  }
}

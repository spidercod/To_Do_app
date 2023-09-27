import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/bloc/Lock/lock_bloc.dart';
import 'package:todo_app/bloc/todo/bloc/todo_bloc.dart';
import 'package:todo_app/repositories/lock_repository.dart';
import 'package:todo_app/repositories/todo_repository.dart';
import 'package:todo_app/ui/add_todo_screen.dart';
import 'package:todo_app/ui/widgets/custom_app_bar.dart';
import 'package:todo_app/ui/widgets/fullscreen_bottomsheet.dart';
import 'package:todo_app/util/bottom_sheet.dart';
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
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: kPad(context) * 0.2,
                ),
                BlocConsumer<TodoBloc, TodoState>(
                  listener: (context, state) {
                    if (state is PopState) {
                      pop(context);
                      BlocProvider.of<TodoBloc>(context)
                          .add(LoadTodoListEvent(code));
                    }
                  },
                  builder: (context, state) {
                    if (state is LoadedTodoListState) {
                      return ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        reverse: true,
                        shrinkWrap: true,
                        children: [
                          ...state.todos.map((e) => InkWell(
                                onTap: () {
                                  bottomSheet(context, [
                                    PopUpClass('Mark as Done ', Iconsax.award,
                                        Colors.green, () {
                                      BlocProvider.of<TodoBloc>(context).add(
                                          MarkDoneEvent(e.code, e.task, e.time,
                                              e.animationIndex, 2));
                                    }),
                                    PopUpClass('Mark as Working on it ',
                                        Iconsax.like, Colors.orange, () {
                                      BlocProvider.of<TodoBloc>(context).add(
                                          MarkDoneEvent(e.code, e.task, e.time,
                                              e.animationIndex, 1));
                                    }),
                                    PopUpClass(
                                        'Delete this Task', Iconsax.trash, dark,
                                        () {
                                      BlocProvider.of<TodoBloc>(context)
                                          .add(DeleteTaskEvent(code, e.task));
                                    }),
                                    PopUpClass('Mark as Not Complete ',
                                        Iconsax.moon, Colors.red, () {
                                      BlocProvider.of<TodoBloc>(context).add(
                                          MarkDoneEvent(e.code, e.task, e.time,
                                              e.animationIndex, 0));
                                    }),
                                  ]);
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: kPad(context) * .03,
                                      horizontal: kPad(context) * .05),
                                  child: Container(
                                    padding:
                                        EdgeInsets.all(kPad(context) * 0.05),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: dark.withOpacity(0.1)),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: kPad(context) * .3,
                                          width: kPad(context) * .3,
                                          child: Lottie.asset(
                                              'assets/json/${e.animationIndex}.json',
                                              repeat: true,
                                              reverse: true),
                                        ),
                                        SizedBox(
                                          width: kPad(context) * .05,
                                        ),
                                        Expanded(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              height: kPad(context) * 0.26,
                                              width: kPad(context) * 0.5,
                                              child: Text(
                                                e.task,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 4,
                                                style: style(context).copyWith(
                                                    fontSize:
                                                        kPad(context) * .04,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  DateFormat('dd MMM, yy')
                                                      .format(DateTime
                                                          .fromMicrosecondsSinceEpoch(
                                                              e.time))
                                                      .toString(),
                                                  style: style(context)
                                                      .copyWith(
                                                          fontSize:
                                                              kPad(context) *
                                                                  0.03,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      height:
                                                          kPad(context) * 0.02,
                                                      width:
                                                          kPad(context) * 0.02,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: e.statusIndex ==
                                                                  0
                                                              ? Colors.red
                                                              : e.statusIndex ==
                                                                      1
                                                                  ? Colors
                                                                      .orangeAccent
                                                                  : Colors
                                                                      .green),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          kPad(context) * 0.01,
                                                    ),
                                                    Text(
                                                      e.statusIndex == 0
                                                          ? 'Not Completed'
                                                          : e.statusIndex == 1
                                                              ? 'Working on it'
                                                              : 'Done',
                                                      style: style(context)
                                                          .copyWith(
                                                        fontSize:
                                                            kPad(context) * .03,
                                                        color: dark
                                                            .withOpacity(0.5),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      );
                    }
                    return const SizedBox.shrink();
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

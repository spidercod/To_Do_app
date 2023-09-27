import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo_app/bloc/Lock/lock_bloc.dart';
import 'package:todo_app/bloc/todo/bloc/todo_bloc.dart';
import 'package:todo_app/ui/todo_screen.dart';
import 'package:todo_app/ui/widgets/buttons.dart';
import 'package:todo_app/ui/widgets/custom_app_bar.dart';
import 'package:todo_app/util/constants.dart';
import 'package:todo_app/util/navigator.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  int _code = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<LockBloc, LockState>(
      listener: (context, state) {
//to handle error...
        if (state is ErrorState) {
          print(state.error);
        }

        //here if LoggedInState then we will pushREplacement the page to TodoScreen...
        if (state is LoggedInState) {
          popUntilFirstPage(context);
          replace(
              context,
              BlocProvider(
                create: (context) => TodoBloc(RepositoryProvider.of(context))
                  ..add(
                    LoadTodoListEvent(_code),
                  ),
                child: TodoScreen(
                  code: _code,
                ),
              ));
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            customAppBar(context, 'Enter the code ', Iconsax.home3,
                Iconsax.home3, () {}, () {}),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: kPad(context) * 0.01,
                  ),
                  Center(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: kPad(context) * 0.08),
                      child: Text(
                        _code.toString(),
                        style: style(context).copyWith(
                            fontSize: kPad(context) * 0.1,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: kPad(context) * 0.06),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 9,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, childAspectRatio: 1.0),
                      itemBuilder: (context, index) {
                        return numberButton(
                            context,
                            Text(
                              '${index + 1}',
                              style: style(context)
                                  .copyWith(fontSize: kPad(context) * 0.05),
                            ), () {
                          setState(() {
                            _code = (_code * 10) + (index + 1);
                            print(_code);
                          });
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: kPad(context) * 0.08),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        numberButton(
                            context,
                            Icon(
                              CupertinoIcons.delete_left,
                              size: kPad(context) * 0.05,
                              color: Colors.red,
                            ), () {
                          setState(() {
                            _code = (_code ~/ 10);
                          });
                        }),
                        numberButton(
                            context,
                            Text(
                              '0',
                              style: style(context)
                                  .copyWith(fontSize: kPad(context) * 0.05),
                            ), () {
                          setState(() {
                            _code = (_code * 10) + 0;
                          });
                        }),
                        numberButton(
                            context,
                            Icon(
                              CupertinoIcons.check_mark,
                              size: kPad(context) * 0.05,
                              color: Colors.green,
                            ), () {
                          //here,we will  write the function of login event
                          BlocProvider.of<LockBloc>(context)
                              .add(LoginButtonClickedEvent(_code));
                        }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: kPad(context) * 0.1,
                  ),
                  blueButton(context, 'Register Instead', () {
                    //here,we will  write the function of register event
                    BlocProvider.of<LockBloc>(context)
                        .add(RegisterButtonClickedEvent(_code));
                  })
                ],
              ),
            ),
          ],
        );
      },
    ));
  }
}

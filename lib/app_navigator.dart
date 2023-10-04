import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_aws_block/auth_cubit.dart';
import 'package:to_do_app_aws_block/auth_state.dart';
import 'package:to_do_app_aws_block/auth_view.dart';
import 'package:to_do_app_aws_block/todo_cubit.dart';
import 'package:to_do_app_aws_block/todos_view.dart';
import 'package:to_do_app_aws_block/widgets/loading_view.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Navigator(
        pages: [
          if (state is Unauthenticated) const MaterialPage(child: AuthView()),
          if (state is Authenticated)
            MaterialPage(
              child: BlocProvider(
                create: (context) => TodoCubit(userId: state.userId)
                  ..getTodos()
                  ..observeTodo(),
                child: const TodosView(),
              ),
            ),
          if (state is UnknownAuthState)
            const MaterialPage(child: LoadingView())
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}

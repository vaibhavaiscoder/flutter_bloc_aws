import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_aws_block/amplifyconfiguration.dart';
import 'package:to_do_app_aws_block/app_navigator.dart';
import 'package:to_do_app_aws_block/auth_cubit.dart';
import 'package:to_do_app_aws_block/models/ModelProvider.dart';
import 'package:to_do_app_aws_block/todo_cubit.dart';
import 'package:to_do_app_aws_block/todos_view.dart';
import 'package:to_do_app_aws_block/widgets/loading_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _amplifyConfigured = false;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider(
            create: (context) => AuthCubit()..attemptAutoSignIn(),
            child: _amplifyConfigured
                ? const AppNavigator()
                : const LoadingView()));
  }

  void _configureAmplify() async {
    // Once Plugins are added, configure Amplify
    try {
      await Future.wait([
        Amplify.addPlugin(
            AmplifyDataStore(modelProvider: ModelProvider.instance)),
        Amplify.addPlugin(AmplifyAPI()),
        Amplify.addPlugin(AmplifyAuthCognito())
      ]);
      await Amplify.configure(amplifyconfig);
      setState(() {
        _amplifyConfigured = true;
      });
      // Amplify.DataStore.clear();
    } catch (e) {
      print(e);
    }
  }
}

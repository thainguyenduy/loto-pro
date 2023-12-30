import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ld_app/src/infrastructure/injector.dart';
import 'package:ld_app/src/screens/login/bloc/login_bloc.dart';
import 'package:ld_app/src/screens/login/login_form.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) => locator<LoginBloc>(),
          child: const LoginForm(),
        ),
      ),
    );
  }
}

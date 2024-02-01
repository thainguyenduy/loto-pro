import 'package:auto_route/auto_route.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ld_app/src/application/app/app.dart';
import 'package:ld_app/src/presentation/router/router.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<AppStatus>(
      state: context.select((AppBloc bloc) => bloc.state.status),
      onGeneratePages: onGenerateAppViewPages,
    );
  }
}

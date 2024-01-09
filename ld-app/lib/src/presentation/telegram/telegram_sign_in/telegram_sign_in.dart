import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ld_app/src/application/telegram_auth/telegram_authentication.dart';

@RoutePage()
class TelegramSignInScreen extends StatefulWidget {
  const TelegramSignInScreen({super.key});

  @override
  State<TelegramSignInScreen> createState() => _TelegramSignInScreenState();
}

class _TelegramSignInScreenState extends State<TelegramSignInScreen> {
  // bool _passwordRequired = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: BlocConsumer<TelegramAuthenticationBloc, TelegramAuthState>(
          listenWhen: (previous, current) =>
              previous.errorMessage != current.errorMessage,
          listener: (context, state) {
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage!),
                  ),
                );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  children: [
                    // no validation for you at all, sorry :(
                    if (state.status == TelegramAuthStatus.waitPhoneNumber ||
                        state.status == TelegramAuthStatus.loggedOut)
                      TextField(
                        key: UniqueKey(),
                        decoration: const InputDecoration(
                          hintText: 'Phone number (with country code)',
                        ),
                        autofocus: true,
                        keyboardType: TextInputType.phone,
                        onSubmitted: (value) => context
                            .read<TelegramAuthenticationBloc>()
                            .add(TelegramAuthPhoneNumberSubmitted(value)),
                      ),
                    if (state.status == TelegramAuthStatus.waitCode)
                      TextField(
                        key: UniqueKey(),
                        decoration: const InputDecoration(
                          hintText: 'Verification code',
                        ),
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        onSubmitted: (value) => context
                            .read<TelegramAuthenticationBloc>()
                            .add(TelegramAuthCodeSubmitted(value)),
                      ),
                    if (state.status == TelegramAuthStatus.waitPassword)
                      TextField(
                        key: UniqueKey(),
                        decoration: const InputDecoration(
                          hintText: '2FA Password',
                        ),
                        autofocus: true,
                        obscureText: true,
                        onSubmitted: (value) => context
                            .read<TelegramAuthenticationBloc>()
                            .add(TelegramAuthPasswordSubmitted(value)),
                      ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}

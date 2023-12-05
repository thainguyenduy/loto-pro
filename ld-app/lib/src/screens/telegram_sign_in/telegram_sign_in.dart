import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../telegram_home/telegram_home.dart';

@RoutePage()
class TelegramSignInScreen extends StatefulWidget {
  const TelegramSignInScreen({super.key});

  @override
  State<TelegramSignInScreen> createState() => _TelegramSignInScreenState();
}

class _TelegramSignInScreenState extends State<TelegramSignInScreen> {
  bool _codeSent = false;
  bool _passwordRequired = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              // no validation for you at all, sorry :(
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Phone number (with country code)',
                ),
                autofocus: true,
                keyboardType: TextInputType.phone,
                onSubmitted: (value) => setState(() => _codeSent = true),
              ),
              if (_codeSent)
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Verification code',
                  ),
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  onSubmitted: (value) =>
                      setState(() => _passwordRequired = true),
                ),
              if (_passwordRequired)
                TextField(
                  decoration: const InputDecoration(
                    hintText: '2FA Password',
                  ),
                  autofocus: true,
                  obscureText: true,
                  onSubmitted: (value) => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TelegramHomeScreen()),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

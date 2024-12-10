import 'dart:io';

import 'package:atproto/atproto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skygazer/views/app_bar_header.dart';

import '/models/auth.dart';
import '/providers/auth.dart';
import '/views/auth/register.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  String email = '';
  String password = '';

  submit(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final session =
          await createSession(identifier: email, password: password);
      if (session.status.code == HttpStatus.ok) {
        final auth = Auth(session: session.data);
        ref.watch(authProvider.notifier).state = auth;
      }
    } catch (err) {
      messenger.showSnackBar(SnackBar(
        content: Text(err.toString()),
        showCloseIcon: true,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'Login',
              textScaler: TextScaler.linear(2),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'Handle',
                        icon: Icon(Icons.person),
                        label: Text('Handle'),
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      decoration: const InputDecoration(
                          icon: Icon(Icons.password), label: Text('Password')),
                      obscureText: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: FilledButton(
                          onPressed: () => submit(context),
                          child: const Text('Login'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const Register(),
                ));
              },
              child: const Text('Register an account'),
            ),
          ],
        ),
      ),
    );
  }
}

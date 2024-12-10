import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skygazer/views/app_bar_header.dart';

import '../auth/login.dart';

class Register extends ConsumerStatefulWidget {
  const Register({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
  String? handle;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'Register',
              textScaler: TextScaler.linear(2),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'your user handle',
                        label: Text('Handle'),
                      ),
                      onChanged: (value) => setState(() {
                        handle = value;
                      }),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email_rounded),
                        hintText: 'user@example.com',
                        label: Text('Email'),
                      ),
                      onChanged: (value) => setState(() {
                        handle = value;
                      }),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.password_rounded),
                        label: Text('Password'),
                      ),
                      onChanged: (value) => setState(() {
                        handle = value;
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilledButton(
                        onPressed: () {},
                        child: const Text('Register'),
                      ),
                    )
                  ],
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const Login(),
                  ));
                },
                child: const Text('Login'))
          ],
        ),
      ),
    );
  }
}

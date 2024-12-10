import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  String email = '';
  String password = '';

  submit(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            'Login',
            style: TextStyle(fontSize: 20),
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
                        hintText: 'Email', icon: Icon(Icons.person)),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    decoration: const InputDecoration(
                        hintText: 'Password', icon: Icon(Icons.password)),
                    obscureText: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: FilledButton(
                        onPressed: () {},
                        child: const Text('Login'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

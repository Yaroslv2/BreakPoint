import 'package:brandpoint/application/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Login"),
          onPressed: () {
            BlocProvider.of<AuthBloc>(context)
              ..add(UserLogIn(email: "Hello", password: "Reee"));
          },
        ),
      ),
    );
  }
}

import 'package:brandpoint/application/auth/bloc/auth_bloc.dart';
import 'package:brandpoint/presentation/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.white10,
            title: LoginPageDesign().Logo),
        body: const Padding(padding: EdgeInsets.all(10), child: _SignInForm()));
  }
}

class _SignInForm extends StatefulWidget {
  const _SignInForm({super.key});

  @override
  State<_SignInForm> createState() => __SignInFormState();
}

class __SignInFormState extends State<_SignInForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
                label: Text("e-mail", style: LoginPageDesign().formFieldStyle),
                isDense: true,
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(25)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(25))),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          TextFormField(
            obscureText: true,
            controller: _passwordController,
            decoration: InputDecoration(
                label:
                    Text("password", style: LoginPageDesign().formFieldStyle),
                isDense: true,
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(25)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(25))),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          ElevatedButton(onPressed: () {}, child: Text("LOG IN"))
        ],
      ),
    );
  }
}

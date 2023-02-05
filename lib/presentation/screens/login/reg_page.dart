import 'package:brandpoint/application/auth/bloc/auth_bloc.dart';
import 'package:brandpoint/presentation/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationPage extends StatelessWidget {
  final AuthBloc bloc;

  const RegistrationPage(this.bloc, {super.key});

  @override
  Widget build(context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 0.01 * MediaQuery.of(context).size.height,
              horizontal: 0.02 * MediaQuery.of(context).size.width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Center(child: LoginPageDesign().Logo),
              ),
              Flexible(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _RegistrationForm(bloc),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have account?",
                          style: LoginPageDesign().greyTextStyle,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Login",
                            style: LoginPageDesign().textStyle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegistrationForm extends StatefulWidget {
  final AuthBloc bloc;

  const _RegistrationForm(this.bloc);

  @override
  State<_RegistrationForm> createState() => __RegistrationFormState();
}

class __RegistrationFormState extends State<_RegistrationForm> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Create a new account",
            style: GoogleFonts.openSans(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
                label: Text("Username", style: LoginPageDesign().textStyle),
                isDense: true,
                prefixIcon: const Icon(
                  Icons.account_circle_outlined,
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
            controller: _emailController,
            decoration: InputDecoration(
                label: Text("E-mail", style: LoginPageDesign().textStyle),
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
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
                label: Text("Password", style: LoginPageDesign().textStyle),
                isDense: true,
                prefixIcon: const Icon(
                  Icons.key_outlined,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(25)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(25))),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          SizedBox(
            height: 0.06 * MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                widget.bloc.add(
                  UserRegistration(
                    name: _usernameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                  ),
                );
                Navigator.of(context).pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                "LOG IN",
                style: GoogleFonts.openSans(
                    color: Colors.white, fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

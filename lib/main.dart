import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:brandpoint/application/auth/bloc/auth_bloc.dart';
import 'package:brandpoint/application/auth/services/authefication_service.dart';
import 'package:brandpoint/presentation/bottom_navigation.dart';
import 'package:brandpoint/presentation/screens/login/login_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.black,
          primarySwatch: Colors.grey,
        ),
        home: RepositoryProvider(
          create: (context) => AutheficationService(),
          child: BlocProvider<AuthBloc>(
            create: (context) {
              return AuthBloc(
                  RepositoryProvider.of<AutheficationService>(context))
                ..add(AppLoad());
            },
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  print(state.message);
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Error occured"),
                      content: Text(state.message),
                    ),
                  );
                  BlocProvider.of<AuthBloc>(context)
                      .emit(AuthNotAutheficated());
                }
              },
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthNotAutheficated) {
                    return LoginPage();
                  }
                  if (state is AuthAutheficated) {
                    return const BottomBar();
                  }
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ),
          ),
        ));
  }
}

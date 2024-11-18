import 'package:bloc_clean_architecture/features/auth/data/firebase_auth_repo.dart';
import 'package:bloc_clean_architecture/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/presentation/cubits/auth_states.dart';
import 'features/auth/presentation/pages/auth_page.dart';
import 'post/presentation/pages/home_page.dart';
import 'themes/light_mode.dart';

/* 
APP - Root level

Repositories: for state management
  - auth
  - profile
  - post
  - search 
  - theme

Check Auth State 
  - unauthorized --> auth page (login/register)
  - authorized --> home page
*/

class MyApp extends StatelessWidget {
  final authRepo = FirebaseAuthRepo();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // providing cubit to app
    return BlocProvider(
      create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        home: BlocConsumer<AuthCubit, AuthState>(
            builder: (context, authState) {
              print(authState);
              //unauthorized -> auth page (login/register)
              if (authState is Unauthenticated) {
                return const AuthPage();
              }
              // authenticated -> home page
              if (authState is Authenticated) {
                return const HomePage();
              }
              // loading
              else {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
            listener: (context, state) {}),
      ),
    );
  }
}

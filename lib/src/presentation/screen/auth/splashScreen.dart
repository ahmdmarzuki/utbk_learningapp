import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';
import '../feature/home_screen.dart';
import 'login_screen.dart';
import 'register_form_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) =>
        context.read<AuthBloc>().add(CheckIsSignedInWithGoogleEvent()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: ((prev, current) {
        bool isResultOfCheckUserSignedInWithGoogle =
            (prev is CheckIsUserSignedInWithGoogleState &&
                    prev.isLoading == true) &&
                (current is CheckIsUserSignedInWithGoogleState &&
                    current.isLoading == false);
        bool isResultOfCheckUserRegistered =
            (prev is CheckIsUserRegisteredState && prev.isLoading == true) &&
                (current is CheckIsUserRegisteredState &&
                    current.isLoading == false);

        return isResultOfCheckUserSignedInWithGoogle ||
            isResultOfCheckUserRegistered;
      }),
      listener: (context, state) {
        if (state is CheckIsUserSignedInWithGoogleState) {
          if (!state.isLoading && state.isSignedIn) {
            //// Check is registered.
            context.read<AuthBloc>().add(CheckIsUserRegisteredEvent());
          } else {
            print("belum login");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          }
        }

        if (state is CheckIsUserRegisteredState) {
          bool isRegistered = state.isRegistered;
          

          if (isRegistered) {
            print("udah login");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          } else {
            print("baru daftar");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RegisterFormScreen(),
              ),
            );
          }
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF3A7FD5),
        body: Center(child: Image.asset('assets/images/edspert.png')),
      ),
    );
  }
}

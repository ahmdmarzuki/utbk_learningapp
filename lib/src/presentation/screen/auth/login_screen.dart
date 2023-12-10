import 'package:final_porject_edspert/src/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:final_porject_edspert/src/presentation/screen/auth/register_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../feature/widgets/custom_button.dart';
import '../feature/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 42),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 30),
                  Image.asset('assets/images/Analysis _Isometric.png'),
                  const SizedBox(height: 56),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Selamat Datang",
                        style: GoogleFonts.poppins(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Selamat Datang di Aplikasi Widya Edu Aplikasi Latihan dan Konsultasi Soal",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  BlocListener<AuthBloc, AuthState>(
                    listenWhen: (prev, current) =>
                        (prev is SignInWithGoogleState &&
                                prev.isLoading == true) &&
                            (current is SignInWithGoogleState &&
                                current.isLoading == false) ||
                        (prev is CheckIsUserRegisteredState &&
                                prev.isLoading == true) &&
                            (current is CheckIsUserRegisteredState &&
                                current.isLoading == false),
                    listener: (context, state) {
                      if (state is SignInWithGoogleState) {
                        if (!state.isLoading && state.result != null) {
                          //// Check is registered.
                          context
                              .read<AuthBloc>()
                              .add(CheckIsUserRegisteredEvent());
                        } else {
                          print('Login cancelled!');
                        }
                      }
                      // TODO: handler for CheckIsUserRegisteredEvent
                      if (state is CheckIsUserRegisteredState) {
                        bool isRegistered = state.isRegistered;

                        if (isRegistered) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RegisterFormScreen()),
                          );
                        }
                      }
                    },
                    child: CustomButton(
                      icon: 'assets/icon/google-icon.png',
                      text: "Masuk dengan Google",
                      bgColor: Colors.white,
                      textColor: Colors.black,
                      onPressed: () {
                        context.read<AuthBloc>().add(SignInWithGoogleEvent());
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return const HomeScreen();
                        //     },
                        //   ),
                        // );
                      },
                    ),
                  ),
                  const SizedBox(height: 25),
                  const CustomButton(
                    icon: 'assets/icon/apple-logo.png',
                    text: "Masuk dengan Apple ID",
                    bgColor: Colors.black,
                    textColor: Colors.white,
                  ),
                  const SizedBox(height: 70)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

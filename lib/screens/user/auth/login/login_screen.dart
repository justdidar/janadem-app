import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:janadem/constants/assets.dart';
import 'package:janadem/screens/user/auth/forgot_password/forgot_password.dart';
import 'package:janadem/screens/user/auth/sign_up/sign_up_screen.dart';
import 'package:janadem/screens/widgets/textform_widget.dart';
import 'package:janadem/screens/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  final int status;
  const LoginScreen({super.key, required this.status});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool passwordVisible = true;
  bool loginButtonPressed = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Listener(
            behavior: HitTestBehavior.opaque,
            onPointerDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Login',
                        style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w400, color: const Color(0xff2C2C2C))),
                    Text('Welcome back!',
                        style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xff2C2C2C))),
                    const SizedBox(height: 10),


                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email', style: GoogleFonts.inter(fontSize: 14)),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: textFieldBorder(const Color(0xff797979)),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'example@mail.com',
                              contentPadding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'It is necessary to fill in the field';
                              final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
                              if (!emailRegex.hasMatch(value)) return 'Incorrect email';
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),


                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Password', style: GoogleFonts.inter(fontSize: 14)),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: passwordVisible,
                            decoration: InputDecoration(
                              border: textFieldBorder(const Color(0xff797979)),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Password',
                              contentPadding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                              suffixIcon: GestureDetector(
                                onTap: () => setState(() => passwordVisible = !passwordVisible),
                                child: SvgPicture.asset(
                                  passwordVisible ? '${Assets().icn}not_visible.svg' : '${Assets().icn}visible.svg',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                            validator: (value) => value == null || value.isEmpty ? 'It is necessary to fill in the field' : null,
                          ),
                        ),
                      ],
                    ),


                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () => Get.to(() => const ForgotPasswordScreen()),
                            child: Text('Forgot Password?', style: GoogleFonts.inter(fontSize: 16)),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: loginButtonPressed ? null : _loginUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff056C5F),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: loginButtonPressed
                              ? const CircularProgressIndicator(color: Colors.white)
                              : Text('Login', style: GoogleFonts.inter(fontSize: 17, color: Colors.white)),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don’t have an account?', style: GoogleFonts.inter(fontSize: 15)),
                          const SizedBox(width: 3),
                          GestureDetector(
                            onTap: () => Get.offAll(() => const SignUpScreen(status: 1)),
                            child: Text('Sign Up', style: GoogleFonts.inter(fontSize: 15, color: const Color(0xff469BD8))),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loginUser() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => loginButtonPressed = true);

    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await Future.delayed(const Duration(milliseconds: 500));

      setState(() => loginButtonPressed = false);

      Get.offAll(() => const UserBottomNavBar());
    } on FirebaseAuthException catch (e) {
      setState(() => loginButtonPressed = false);
      Get.snackbar('Error', e.message ?? 'Login error',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}

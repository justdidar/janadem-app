import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:janadem/constants/assets.dart';
import 'package:janadem/screens/user/auth/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      chooseEnroll();
    });
  }

  void chooseEnroll() {
    showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        context: context,
        builder: (builder) {
          return const Wrap(
            children: [
              EnrollType()
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff056C5F),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('${Assets().img}logo_white.svg'),
              const SizedBox(height: 1),
              Text(
                'JANADEM',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 23,
                    color: Colors.white,
                    letterSpacing: 10
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EnrollType extends StatelessWidget {
  const EnrollType({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
              color: Colors.transparent,
              child: SvgPicture.asset('${Assets().icn}bottom_line.svg')
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 30),
                  child: Text(
                    'What type of account would you like to create?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offAll(() => const LoginScreen(status: 1));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                                width: 1,
                                color: Color(0xff1849D6)
                            ),
                          ),
                          backgroundColor: Colors.white,
                          splashFactory: NoSplash.splashFactory,
                          elevation: 0
                      ),
                      child: Text(
                        'User',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff1849D6)
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offAll(() => const LoginScreen(status: 3)); // Get.offAll(() => const AkimLoginScreen(status: 3));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: const Color(0xff056C5F),
                          splashFactory: NoSplash.splashFactory,
                          elevation: 0
                      ),
                      child: Text(
                        'Akim',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 30),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offAll(() => const LoginScreen(status: 2)); // Get.offAll(() => const AkimLoginScreen(status: 2));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                                width: 1,
                                color: Color(0xff1849D6)
                            ),
                          ),
                          backgroundColor: Colors.white,
                          splashFactory: NoSplash.splashFactory,
                          elevation: 0
                      ),
                      child: Text(
                        'Moderator',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff1849D6)
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

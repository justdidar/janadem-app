import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:janadem/screens/user/auth/forgot_password/change_password.dart';
import 'package:pinput/pinput.dart';

class EnterCodeScreen extends StatefulWidget {
  const EnterCodeScreen({super.key});

  @override
  State<EnterCodeScreen> createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen>  {

  final formKey = GlobalKey<FormState>();

  final TextEditingController pinEditingController = TextEditingController();

  @override
  void dispose() {
    pinEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Enter Code',
          style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: const Color(0xff2C2C2C)
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Listener(
            behavior: HitTestBehavior.opaque,
            onPointerDown: (_) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        'Kindly enter the code sent to your phone number',
                        style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff2C2C2C)
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Pinput(
                              controller: pinEditingController,
                              length: 4,
                              defaultPinTheme: PinTheme(
                                width: 60,
                                height: 60,
                                textStyle: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 23,
                                    color: Colors.black
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              focusedPinTheme: PinTheme(
                                width: 60,
                                height: 60,
                                textStyle: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 23,
                                    color: Colors.black
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black,
                                      width: 2
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onChanged: (value) async{
                              },
                            ),
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
                          onPressed: () async {
                            Get.to(
                                () => const ChangePasswordScreen()
                            );
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
                            'Verify code',
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

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

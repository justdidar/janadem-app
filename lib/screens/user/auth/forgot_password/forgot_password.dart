import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:janadem/constants/assets.dart';
import 'package:janadem/screens/user/auth/forgot_password/enter_code.dart';
import 'package:janadem/screens/widgets/textform_widget.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final formKey = GlobalKey<FormState>();

  TextEditingController phoneNumberController = TextEditingController();

  var maskFormatter = MaskTextInputFormatter(
      mask: '+#(###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SvgPicture.asset('${Assets().icn}forgot_password.svg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Forgot your password?',
                        style: GoogleFonts.inter(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff1F1F1F)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        'Enter your registered phone number below to receive password reset instruction',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff8F8F8F)
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Phone Number',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff2C2C2C)
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              controller: phoneNumberController,
                              cursorColor: const Color(0xff1A1B22),
                              cursorWidth: 1,
                              cursorHeight: 20,
                              keyboardType: TextInputType.text,
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17,
                                  color: const Color(0xff1A1B22)
                              ),
                              inputFormatters: [maskFormatter],
                              decoration: InputDecoration(
                                border: textFieldBorder(const Color(0xff797979)),
                                focusedBorder: textFieldBorder(const Color(0xff797979)),
                                disabledBorder: textFieldBorder(const Color(0xff797979)),
                                enabledBorder: textFieldBorder(const Color(0xff797979)),
                                errorBorder: textFieldBorder(const Color(0xffFF3636)),
                                focusedErrorBorder: textFieldBorder(const Color(0xffFF3636)),
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                hintText: '+7(701) 000-00-00',
                                fillColor: Colors.white,
                                hintStyle: GoogleFonts.inter(
                                  color: const Color(0xffBCBCBC),
                                  fontSize: 17,
                                ),
                                errorStyle: GoogleFonts.inter(
                                  color: const Color(0xffFF3636),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'It is necessary to fill in the field';
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value){

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
                                () => const EnterCodeScreen()
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
                            'Verify',
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
